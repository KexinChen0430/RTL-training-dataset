
module dffrl_async_ns(din,clk,rst_l,q);

  parameter  SIZE = 1;
  input  [(-1)+SIZE:0] din;
  input  clk;
  input  rst_l;
  output [(-1)+SIZE:0] q;
  reg  [(-1)+SIZE:0] q;

  
  always @(posedge clk or negedge rst_l)
      q[(-1)+SIZE:0] <= ~rst_l ? {SIZE{1'b0}} : ({SIZE{rst_l}} & din[(-1)+SIZE:0]);
endmodule

