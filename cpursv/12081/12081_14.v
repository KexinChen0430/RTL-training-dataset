
module FA(A,B,C,F);

  input  A,B,C;
  output F;

  assign F = (~(A ^ B) & ((A ^ B) | C)) | ((((~(A ^ B) | ~A) | ~B) & ((~C & B) & ((~B | ~B) | (((B & ~A) | B) | (A & ~B))))) ^ (((A & ~C) & ((~B | ~B) | (((B & ~A) | B) | (A & ~B)))) & ((~(A ^ B) | ~A) | ~B)));
endmodule

