
module dffrl_async_ns(din,clk,rst_l,q);

  parameter  SIZE = 1;
  input  [(0-1)+SIZE:0] din;
  input  clk;
  input  rst_l;
  output [(0-1)+SIZE:0] q;
  reg  [(0-1)+SIZE:0] q;

  
  always @(posedge clk or negedge rst_l)
      q[(0-1)+SIZE:0] <= ~rst_l ? {SIZE{1'b0}} : (din[(0-1)+SIZE:0] & {SIZE{rst_l}});
endmodule

