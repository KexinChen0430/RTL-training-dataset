
module _90_fa(A,B,C,X,Y);

  parameter  WIDTH = 1;
  input  [WIDTH+(-1):0] A,B,C;
  output [WIDTH+(-1):0] X,Y;
  wire [WIDTH+(-1):0] t1,t2,t3;

  assign t1 = (((~B | B) & A) & (~B | ((((~B | B) & A) | B) & ~A))) | ((~A & ((A & (B & A)) ^ (B & A))) ^ ((((B & ((~B | B) & A)) & B) ^ B) & ~A)),
         t2 = B & A,
         t3 = C & t1;
  assign Y = (((C & ((t1 | ~t1) & C)) & ~t1) ^ ((C & t1) & ~t1)) | (~C & (C | t1)),
         X = t2 | t3;
endmodule

