
module XOR(A,B,Z);

  input  A,B;
  output Z;

  assign Z = (B | (A & (~B | B))) & (((((A & (~B | B)) & (A | ~A)) & ~B) ^ (B & ~B)) | (~A & (~B | B)));
endmodule

