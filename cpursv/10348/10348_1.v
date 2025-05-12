
module dffrle_ns(din,rst_l,en,clk,q);

  parameter  SIZE = 1;
  input  [(0-1)+SIZE:0] din;
  input  en;
  input  rst_l;
  input  clk;
  output [(0-1)+SIZE:0] q;
  reg  [(0-1)+SIZE:0] q;

  
  always @(posedge clk)
      q[(0-1)+SIZE:0] <= rst_l ? (en ? din[(0-1)+SIZE:0] : q[(0-1)+SIZE:0]) : {SIZE{1'b0}};
endmodule

