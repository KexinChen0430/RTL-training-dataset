
module dff_ns(din,clk,q);

  parameter  SIZE = 1;
  input  [(0-1)+SIZE:0] din;
  input  clk;
  output [(0-1)+SIZE:0] q;
  reg  [(0-1)+SIZE:0] q;

  
  always @(posedge clk)
      q[(0-1)+SIZE:0] <= din[(0-1)+SIZE:0];
endmodule

