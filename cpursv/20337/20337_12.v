
module oh_par2ser  #(parameter  PW = 64, SW = 1, CW = $clog2(PW/SW))
  (input  clk,
   input  nreset,
   input  [(0-1)+PW:0] din,
   output [SW+(0-1):0] dout,
   output access_out,
   input  load,
   input  shift,
   input  [7:0] datasize,
   input  lsbfirst,
   input  fill,
   input  wait_in,
   output wait_out);

  reg  [(0-1)+PW:0] shiftreg;
  reg  [(0-1)+CW:0] count;
  wire start_transfer;
  wire busy;

  assign start_transfer = ~busy & (load & ~wait_in);
  
  always @(posedge clk or negedge nreset)
      if (!nreset) count[(0-1)+CW:0] <= 'b0;
      else if (start_transfer) count[(0-1)+CW:0] <= datasize[(0-1)+CW:0];
      else if (shift & busy) count[(0-1)+CW:0] <= count[(0-1)+CW:0]-1'b1;
        
  assign busy = |count[(0-1)+CW:0];
  assign access_out = busy;
  assign wait_out = wait_in | busy;
  
  always @(posedge clk)
      if (start_transfer) shiftreg[(0-1)+PW:0] = din[(0-1)+PW:0];
      else if (lsbfirst & shift) shiftreg[(0-1)+PW:0] = {{SW{fill}},shiftreg[(0-1)+PW:SW]};
      else if (shift) shiftreg[(0-1)+PW:0] = {shiftreg[(PW-SW)-1:0],{SW{fill}}};
        
  assign dout[SW+(0-1):0] = lsbfirst ? shiftreg[SW+(0-1):0] : shiftreg[(0-1)+PW:PW-SW];
endmodule

