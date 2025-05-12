
module FA(A,B,C,F);

  input  A,B,C;
  output F;

  assign F = ((~A | ~B) & (((B & ~A) | A) & ((~((((B & ~A) | A) & ~B) | (~A & ((B & ~A) | A))) & C) | ~C))) | (~((((B & ~A) | A) & ~B) | (~A & ((B & ~A) | A))) & C);
endmodule

