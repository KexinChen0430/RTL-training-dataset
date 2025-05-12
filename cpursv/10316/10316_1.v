
module dffrl_ns(din,clk,rst_l,q);

  parameter  SIZE = 1;
  input  [(0-1)+SIZE:0] din;
  input  clk;
  input  rst_l;
  output [(0-1)+SIZE:0] q;
  reg  [(0-1)+SIZE:0] q;

  
  always @(posedge clk)
      q[(0-1)+SIZE:0] <= rst_l ? din[(0-1)+SIZE:0] : {SIZE{1'b0}};
endmodule

