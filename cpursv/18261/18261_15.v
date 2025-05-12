
module XNOR(A,B,Z);

  input  A,B;
  output Z;

  assign Z = ~((B ^ ((B & A) & (B | A))) | (((~(B & ~B) & (((~B | (B | A)) & (A & (~B | (B | A)))) & ~B)) | ~(((~B | (B | A)) & (A & (~B | (B | A)))) & ~B)) & ((~(B & ~B) & (((~B | (B | A)) & (A & (~B | (B | A)))) & ~B)) | (B & ~B))));
endmodule

