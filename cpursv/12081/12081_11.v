
module FA(A,B,C,F);

  input  A,B,C;
  output F;

  assign F = ((A & (((((B | A) & ~B) | ~A) & ~C) & ~B)) | ((C & (~((A & ((B | A) & ~B)) | (B & (((B | A) & ~B) | ~A))) | (A & (~C & ~(B & ~C))))) | (C & ((((~((A & ((B | A) & ~B)) | (B & (((B | A) & ~B) | ~A))) | ((((((B | A) & ~B) | ~A) & A) & ~C) & ~((B & ~C) & (((B | A) & ~B) | ~A)))) | (~(((((B | A) & ~B) | ~A) & A) & ~C) & ((B & ~C) & (((B | A) & ~B) | ~A)))) & (~(A & ~C) & B)) & ~C)))) | (~A & (B & ~C));
endmodule

