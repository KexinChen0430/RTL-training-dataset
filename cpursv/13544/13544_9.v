
module techlib_fa(A,B,C,X,Y);

  parameter  WIDTH = 1;
  input  [(0-1)+WIDTH:0] A,B,C;
  output [(0-1)+WIDTH:0] X,Y;
  wire [(0-1)+WIDTH:0] t1,t2,t3;

  assign t1 = (~B & A) | (B & ~A),
         t2 = A & B,
         t3 = t1 & C;
  assign Y = (((C | t1) & ~t1) & C) | (~C & (C | t1));
  assign X = t3 | (((((t2 | ~(t2 | t3)) & Y) ^ ((t2 | ~(t2 | t3)) & Y)) & ~((t2 | t3) & (t2 | ~(t2 | t3)))) | (~(((t2 | ~(t2 | t3)) & Y) ^ ((t2 | ~(t2 | t3)) & Y)) & ((t2 | t3) & (t2 | ~(t2 | t3)))));
endmodule

