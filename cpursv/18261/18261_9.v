
module XNOR(A,B,Z);

  input  A,B;
  output Z;

  assign Z = ~(B ^ ((B | A) & ((~B | B) & ((~B | B) & A))));
endmodule

