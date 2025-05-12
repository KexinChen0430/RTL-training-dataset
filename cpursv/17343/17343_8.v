
module _90_fa(A,B,C,X,Y);

  parameter  WIDTH = 1;
  input  [(-1)+WIDTH:0] A,B,C;
  output [(-1)+WIDTH:0] X,Y;
  wire [(-1)+WIDTH:0] t1,t2,t3;

  assign t1 = (B & (~A | A)) ^ (((~A | A) & ((~B | B) & A)) & (((~B | B) & A) | B)),
         t2 = A & B,
         t3 = t1 & C;
  assign Y = C ^ (t1 & (((C & (t1 | (~C | ~t1))) | t1) | ~C)),
         X = t2 | t3;
endmodule

