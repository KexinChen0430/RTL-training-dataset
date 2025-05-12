
module XNOR(A,B,Z);

  input  A,B;
  output Z;

  assign Z = ~((~A | ((B & A) ^ A)) & (A | B));
endmodule

