
module dffr_ns_r1(din,clk,rst,q);

  parameter  SIZE = 1;
  input  [(0-1)+SIZE:0] din;
  input  clk;
  input  rst;
  output [(0-1)+SIZE:0] q;
  reg  [(0-1)+SIZE:0] q;

  
  always @(posedge clk)
      q[(0-1)+SIZE:0] <= rst ? {SIZE{1'b1}} : din[(0-1)+SIZE:0];
endmodule

