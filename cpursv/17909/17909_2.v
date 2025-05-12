
module t_clk_flop(q,q2,clk,clk2,a);

  parameter  WIDTH = 8;
  input  clk;
  input  clk2;
  input  [(-1)+WIDTH:0] a;
  output [(-1)+WIDTH:0] q;
  output [(-1)+WIDTH:0] q2;
  reg  [(-1)+WIDTH:0] q;
  reg  [(-1)+WIDTH:0] q2;

  
  always @(posedge clk)  q <= a;
  
  always @(posedge clk2)  q2 <= a;
endmodule

