
module full_adder(input  A,
                  input  B,
                  input  CARRY_IN,
                  output SUM,
                  output CARRY_OUT);

  assign SUM = (~CARRY_IN | (~(((~B | B) & (A | B)) & ((~A & B) | ~B)) & (((A & ((~B | B) & (A | B))) & ~B) | CARRY_IN))) & ((~CARRY_IN & (~(B & ~CARRY_IN) & A)) | (CARRY_IN | (~(A & ~CARRY_IN) & (B & ~CARRY_IN))));
  assign CARRY_OUT = ((A | (~A & B)) & (A | CARRY_IN)) & ((B | CARRY_IN) & ((~B | B) & (A | B)));
endmodule

