
module dffr_ns(din,clk,rst,q);

  parameter  SIZE = 1;
  input  [(-1)+SIZE:0] din;
  input  clk;
  input  rst;
  output [(-1)+SIZE:0] q;
  reg  [(-1)+SIZE:0] q;

  
  always @(posedge clk)
      q[(-1)+SIZE:0] <= rst ? {SIZE{1'b0}} : din[(-1)+SIZE:0];
endmodule

