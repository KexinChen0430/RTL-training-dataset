
module FA(A,B,C,F);

  input  A,B,C;
  output F;

  assign F = (((~B & (A | B)) | ((~A & B) | C)) & ~C) | (~(((A | B) & ~A) | (~B & (A | B))) & C);
endmodule

