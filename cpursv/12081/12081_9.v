
module FA(A,B,C,F);

  input  A,B,C;
  output F;

  assign F = (((~((~B & (A | (B & ~A))) | (B & ~A)) | ~((~B & (A | (B & ~A))) | (B & ~A))) | (((~B | (B & ~A)) | ~((~B & (A | (B & ~A))) | (B & ~A))) & ~C)) & (B & ~A)) | ((~((~B & (A | (B & ~A))) | (B & ~A)) & C) | (~B & (~C & A)));
endmodule

