
module techlib_fa(A,B,C,X,Y);

  parameter  WIDTH = 1;
  input  [WIDTH+(0-1):0] A,B,C;
  output [WIDTH+(0-1):0] X,Y;
  wire [WIDTH+(0-1):0] t1,t2,t3;

  assign t1 = ((((~A | ~B) & A) & (~A | A)) & ~((~A | ~B) & B)) | (~(((~A | ~B) & A) & (~A | A)) & ((~A | ~B) & B)),
         t2 = A & B,
         t3 = t1 & C;
  assign Y = (C & (~C | ~t1)) ^ (((~t1 | ((~C & t1) | C)) & ((C | ~C) & t1)) & (~C | ~t1));
  assign X = (t3 | t2) | (((t2 | ~Y) | t3) & Y);
endmodule

