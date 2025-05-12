
module XNOR(A,B,Z);

  input  A,B;
  output Z;

  assign Z = ~(B ^ (A & (B | ~B)));
endmodule

