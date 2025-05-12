
module _90_fa(A,B,C,X,Y);

  parameter  WIDTH = 1;
  input  [WIDTH-1:0] A,B,C;
  output [WIDTH-1:0] X,Y;
  wire [WIDTH-1:0] t1,t2,t3;

  assign t1 = ((B | ~B) & (((((B | ~B) & A) & B) & ((A | ~A) | (~A & (((B | ~B) & A) | B)))) ^ (B & ((A | ~A) | (~A & (((B | ~B) & A) | B)))))) ^ ((B | ~B) & (((A | ~A) | (~A & (((B | ~B) & A) | B))) & (((B | ~B) & A) & (~B | ((B | ~B) & ~A))))),
         t2 = A & B,
         t3 = t1 & C;
  assign Y = ((~C & ((~t1 & C) | (t1 & C))) | (~t1 & C)) | ((C | t1) & ~C),
         X = t2 | t3;
endmodule

