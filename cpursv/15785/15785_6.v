
module delayN(clk,in,out);

  input  clk;
  input  in;
  output out;
  parameter  NDELAY = 3;
  reg  [NDELAY+(0-1):0] shiftreg;
  wire  out = shiftreg[NDELAY+(0-1)];

  
  always @(posedge clk)
      shiftreg <= {shiftreg[(-1<<1)+NDELAY:0],in};
endmodule

