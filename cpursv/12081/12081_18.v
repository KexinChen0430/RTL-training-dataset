
module FA(A,B,C,F);

  input  A,B,C;
  output F;

  assign F = ((C & ~(A ^ B)) | (B & (~A & ~C))) | ((~B & A) & (~C | ((A | ~(A ^ B)) & (~(A ^ B) | (~C & ~B)))));
endmodule

