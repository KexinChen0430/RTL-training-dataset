
module XOR(A,B,Z);

  input  A,B;
  output Z;

  assign Z = (((A | ~A) & ((A | ~A) & (A & (~B | B)))) & ~B) | (~((A | ~A) & ((A | ~A) & (A & (~B | B)))) & B);
endmodule

