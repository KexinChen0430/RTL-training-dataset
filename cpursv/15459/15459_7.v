
module oh_par2ser  #(parameter  PW = 64, SW = 1, CW = $clog2((1/SW)*PW))
  (input  clk,
   input  nreset,
   input  [(-1)+PW:0] din,
   output [SW-1:0] dout,
   output access_out,
   input  load,
   input  shift,
   input  [7:0] datasize,
   input  lsbfirst,
   input  fill,
   input  wait_in,
   output wait_out);

  reg  [(-1)+PW:0] shiftreg;
  reg  [CW+(-1):0] count;
  wire start_transfer;
  wire busy;

  assign start_transfer = ~wait_in & (~busy & load);
  
  always @(posedge clk or negedge nreset)
      if (!nreset) count[CW+(-1):0] <= 'b0;
      else if (start_transfer) count[CW+(-1):0] <= datasize[CW+(-1):0];
      else if (busy & shift) count[CW+(-1):0] <= (-1'b1)+count[CW+(-1):0];
        
  assign busy = |count[CW+(-1):0];
  assign access_out = busy;
  assign wait_out = busy | wait_in;
  
  always @(posedge clk or negedge nreset)
      if (!nreset) shiftreg[(-1)+PW:0] = 'b0;
      else if (start_transfer) shiftreg[(-1)+PW:0] = din[(-1)+PW:0];
      else if (shift & lsbfirst) shiftreg[(-1)+PW:0] = {{SW{fill}},shiftreg[(-1)+PW:SW]};
      else if (shift) 
        shiftreg[(-1)+PW:0] = {shiftreg[(-1)+(PW+(-SW)):0],{SW{fill}}};
        
  assign dout[SW-1:0] = lsbfirst ? shiftreg[SW-1:0] : shiftreg[(-1)+PW:PW+(-SW)];
endmodule

