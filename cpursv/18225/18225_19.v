
module XOR(A,B,Z);

  input  A,B;
  output Z;

  assign Z = B ^ (((~B | B) & A) & (A | ~A));
endmodule

