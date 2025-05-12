
module XNOR(A,B,Z);

  input  A,B;
  output Z;

  assign Z = ~((B & ~(((B | ~B) & ((B | ~B) & A)) & (B | ~B))) | (~B & (((B | ~B) & ((B | ~B) & A)) & (B | ~B))));
endmodule

