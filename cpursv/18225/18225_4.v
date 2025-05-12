
module XOR(A,B,Z);

  input  A,B;
  output Z;

  assign Z = (((((~B & ((((B | ~B) & A) & B) & (~A | A))) | (~((((B | ~B) & A) & B) & (~A | A)) & B)) | ~B) & (((B | ~B) & A) & (B | ~B))) & ~((~B & ((((B | ~B) & A) & B) & (~A | A))) | (~((((B | ~B) & A) & B) & (~A | A)) & B))) | (((~B & ((((B | ~B) & A) & B) & (~A | A))) | (~((((B | ~B) & A) & B) & (~A | A)) & B)) & ~((((~B & ((((B | ~B) & A) & B) & (~A | A))) | (~((((B | ~B) & A) & B) & (~A | A)) & B)) | ~B) & (((B | ~B) & A) & (B | ~B))));
endmodule

