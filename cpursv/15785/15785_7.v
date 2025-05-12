
module delayN(clk,in,out);

  input  clk;
  input  in;
  output out;
  parameter  NDELAY = 3;
  reg  [(0-1)+NDELAY:0] shiftreg;
  wire  out = shiftreg[(0-1)+NDELAY];

  
  always @(posedge clk)
      shiftreg <= {shiftreg[NDELAY+(0-1<<1):0],in};
endmodule

