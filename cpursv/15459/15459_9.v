
module oh_par2ser  #(parameter  PW = 64, SW = 1, CW = $clog2(PW*(1/SW)))
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
  reg  [(-1)+CW:0] count;
  wire start_transfer;
  wire busy;

  assign start_transfer = ~busy & (~wait_in & load);
  
  always @(posedge clk or negedge nreset)
      if (!nreset) count[(-1)+CW:0] <= 'b0;
      else if (start_transfer) count[(-1)+CW:0] <= datasize[(-1)+CW:0];
      else if (shift & busy) count[(-1)+CW:0] <= (-1'b1)+count[(-1)+CW:0];
        
  assign busy = |count[(-1)+CW:0];
  assign access_out = busy;
  assign wait_out = wait_in | busy;
  
  always @(posedge clk or negedge nreset)
      if (!nreset) shiftreg[(-1)+PW:0] = 'b0;
      else if (start_transfer) shiftreg[(-1)+PW:0] = din[(-1)+PW:0];
      else if (shift & lsbfirst) shiftreg[(-1)+PW:0] = {{SW{fill}},shiftreg[(-1)+PW:SW]};
      else if (shift) 
        shiftreg[(-1)+PW:0] = {shiftreg[(-1)+((-SW)+PW):0],{SW{fill}}};
        
  assign dout[SW-1:0] = lsbfirst ? shiftreg[SW-1:0] : shiftreg[(-1)+PW:(-SW)+PW];
endmodule

