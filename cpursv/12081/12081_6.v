
module FA(A,B,C,F);

  input  A,B,C;
  output F;

  assign F = ((A & (~(~C & B) & ~C)) | (~(((~A & B) | (~B & B)) | (((~A & B) | ~B) & A)) & C)) | (~(A & ~C) & (~C & B));
endmodule

