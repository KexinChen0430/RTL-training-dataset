
module _90_fa(A,B,C,X,Y);

  parameter  WIDTH = 1;
  input  [(0-1)+WIDTH:0] A,B,C;
  output [(0-1)+WIDTH:0] X,Y;
  wire [(0-1)+WIDTH:0] t1,t2,t3;

  assign t1 = ((((~A | A) & B) | A) & ~B) | (((((~A | A) & B) & B) & ~A) ^ (~A & (A & B))),
         t2 = A & B,
         t3 = C & t1;
  assign Y = (~C & t1) | ((C & (t1 & (C | ~C))) ^ C),
         X = t2 | t3;
endmodule

