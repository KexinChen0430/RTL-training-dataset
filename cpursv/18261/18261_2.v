
module XNOR(A,B,Z);

  input  A,B;
  output Z;

  assign Z = ~((((A & (~B | (B | A))) & ~B) | ~(A & (~B | (B | A)))) & (((A & (~B | (B | A))) & ~B) | B));
endmodule

