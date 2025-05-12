
module FA(A,B,C,F);

  input  A,B,C;
  output F;

  assign F = (~A & (B & ~C)) | (((~C & ~B) & A) | (C & ((~(((~A & (A | B)) & B) | (((((A | B) & ~B) & A) | ~A) & A)) & C) | ~C)));
endmodule

