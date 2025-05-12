
module dffre_ns(din,rst,en,clk,q);

  parameter  SIZE = 1;
  input  [(-1)+SIZE:0] din;
  input  en;
  input  rst;
  input  clk;
  output [(-1)+SIZE:0] q;
  reg  [(-1)+SIZE:0] q;

  
  always @(posedge clk)
      q[(-1)+SIZE:0] <= rst ? {SIZE{1'b0}} : 
                       en ? din[(-1)+SIZE:0] : q[(-1)+SIZE:0];
endmodule

