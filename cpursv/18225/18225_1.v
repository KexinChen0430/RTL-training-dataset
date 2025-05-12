
module XOR(A,B,Z);

  input  A,B;
  output Z;

  assign Z = B ^ ((~B | (B | A)) & ((~B | (B | A)) & A));
endmodule

