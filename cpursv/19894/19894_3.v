
module fakedelay(d,clk,q);

  parameter  WIDTH = 32;
  input  [(-1)+WIDTH:0] d;
  input  clk;
  output [(-1)+WIDTH:0] q;

  assign q = d;
endmodule

