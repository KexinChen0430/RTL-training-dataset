
module dffe_ns(din,en,clk,q);

  parameter  SIZE = 1;
  input  [(-1)+SIZE:0] din;
  input  en;
  input  clk;
  output [(-1)+SIZE:0] q;
  reg  [(-1)+SIZE:0] q;

  
  always @(posedge clk)
      q[(-1)+SIZE:0] <= en ? din[(-1)+SIZE:0] : q[(-1)+SIZE:0];
endmodule

