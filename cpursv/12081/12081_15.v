
module FA(A,B,C,F);

  input  A,B,C;
  output F;

  assign F = (~((~B & (A | B)) | ((A | B) & ~A)) & C) | (((B & ((A | B) & ~A)) & ((~((~B & (A | B)) | ((A | B) & ~A)) | (~C & ~A)) | ((~C & A) & ~B))) | (((~((~B & (A | B)) | ((A | B) & ~A)) | (~C & ~A)) | ((~C & A) & ~B)) & (A & (~B & (A | B)))));
endmodule

