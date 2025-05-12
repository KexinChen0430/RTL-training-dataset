
module XOR(A,B,Z);

  input  A,B;
  output Z;

  assign Z = (((~B & ((A | ~A) & (A & (B | ~B)))) ^ (B & ~B)) & A) | (((~A & (((~B & ((A | ~A) & (A & (B | ~B)))) ^ (B & ~B)) & A)) | ((B & ~B) | ~A)) & (((A & (B | ~B)) | B) & (B | (~A & (B | ~B)))));
endmodule

