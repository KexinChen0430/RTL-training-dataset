
module dffrl_s(din,clk,rst_l,q,se,si,so);

  parameter  SIZE = 1;
  input  [(0-1)+SIZE:0] din;
  input  clk;
  input  rst_l;
  output [(0-1)+SIZE:0] q;
  input  se;
  input  [(0-1)+SIZE:0] si;
  output [(0-1)+SIZE:0] so;
  reg  [(0-1)+SIZE:0] q;

  
  always @(posedge clk)
      q[(0-1)+SIZE:0] <= rst_l ? (se ? si[(0-1)+SIZE:0] : din[(0-1)+SIZE:0]) : {SIZE{1'b0}};
  assign so[(0-1)+SIZE:0] = q[(0-1)+SIZE:0];
endmodule

