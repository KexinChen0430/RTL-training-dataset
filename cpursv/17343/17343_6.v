
module _90_fa(A,B,C,X,Y);

  parameter  WIDTH = 1;
  input  [WIDTH+(0-1):0] A,B,C;
  output [WIDTH+(0-1):0] X,Y;
  wire [WIDTH+(0-1):0] t1,t2,t3;

  assign t1 = ((~B | ((((B & (~A | A)) & B) & ~A) ^ ((A & B) & ~A))) & (A & (((B & (~A | A)) | A) | ~B))) | ((((B & (~A | A)) & B) & ~A) ^ ((A & B) & ~A)),
         t2 = A & B,
         t3 = t1 & C;
  assign Y = (((t1 | ((~t1 & C) | (t1 & C))) | ~C) & (t1 & ((t1 | ((~t1 & C) | (t1 & C))) | ~C))) ^ (((t1 | ((~t1 & C) | (t1 & C))) | ~C) & (((t1 | ((~t1 & C) | (t1 & C))) | ~C) & ((~t1 & C) | (t1 & C)))),
         X = t3 | t2;
endmodule

