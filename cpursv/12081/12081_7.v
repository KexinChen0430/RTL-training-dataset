
module FA(A,B,C,F);

  input  A,B,C;
  output F;

  assign F = (((B & ~B) | (B & ~A)) & ~C) | ((C & ~((~B | (B & ~A)) & (((B & ~B) | (B & ~A)) | A))) | (~B & (((~B | (B & ~A)) & A) & ~C)));
endmodule

