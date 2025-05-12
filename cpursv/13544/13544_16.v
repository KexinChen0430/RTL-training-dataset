
module techlib_fa(A,B,C,X,Y);

  parameter  WIDTH = 1;
  input  [WIDTH+(-1):0] A,B,C;
  output [WIDTH+(-1):0] X,Y;
  wire [WIDTH+(-1):0] t1,t2,t3;

  assign t1 = (B & (A | ~A)) ^ ((A | ~A) & (((A | B) | ~B) & A)),
         t2 = A & B,
         t3 = t1 & C;
  assign Y = (~C & (C | ((C | ~C) & t1))) | (C & ((C | ((C | ~C) & t1)) & ~t1));
  assign X = (~Y | (t2 | t3)) & ((Y | t3) | t2);
endmodule

