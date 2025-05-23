
module XNOR(A,B,Z);

  input  A,B;
  output Z;

  assign Z = ~((((((B & A) & ~A) | ~(B & A)) & (((B & A) & ~A) | A)) & (B | A)) ^ ((B & ((B | ~B) & A)) ^ B));
endmodule

