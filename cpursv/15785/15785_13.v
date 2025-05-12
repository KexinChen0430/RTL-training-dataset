
module delayN(clk,in,out);

  input  clk;
  input  in;
  output out;
  parameter  NDELAY = 3;
  reg  [(-1)+NDELAY:0] shiftreg;
  wire  out = shiftreg[(-1)+NDELAY];

  
  always @(posedge clk)
      shiftreg <= {shiftreg[(-(1+1))+NDELAY:0],in};
endmodule

