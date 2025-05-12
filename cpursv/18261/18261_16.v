
module XNOR(A,B,Z);

  input  A,B;
  output Z;

  assign Z = ~((((A | ~A) & ((B | ~B) & A)) & (B | A)) ^ B);
endmodule

