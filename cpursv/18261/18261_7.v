
module XNOR(A,B,Z);

  input  A,B;
  output Z;

  assign Z = ~((~A & B) | ((((~B | B) & A) & A) ^ (B & A)));
endmodule

