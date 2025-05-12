
module dffe_ns(din,en,clk,q);

  parameter  SIZE = 1;
  input  [(0-1)+SIZE:0] din;
  input  en;
  input  clk;
  output [(0-1)+SIZE:0] q;
  reg  [(0-1)+SIZE:0] q;

  
  always @(posedge clk)
      q[(0-1)+SIZE:0] <= en ? din[(0-1)+SIZE:0] : q[(0-1)+SIZE:0];
endmodule

