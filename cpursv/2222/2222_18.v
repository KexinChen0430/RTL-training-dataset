
module full_adder(input  A,
                  input  B,
                  input  CARRY_IN,
                  output SUM,
                  output CARRY_OUT);

  assign SUM = ((((A & ~B) | B) | ~((~A | ~B) & ((A & ~B) | B))) & (((~CARRY_IN & ~A) | ((~CARRY_IN & ~B) & A)) | ~((~A | ~B) & ((A & ~B) | B)))) & ((((~CARRY_IN & ~B) & A) | CARRY_IN) | ((~CARRY_IN & B) & ~A));
  assign CARRY_OUT = (B | ((B & ((B & ~A) | CARRY_IN)) ^ (A & ((B & ~A) | CARRY_IN)))) & ((A & (B | ((B & ((B & ~A) | CARRY_IN)) ^ (A & ((B & ~A) | CARRY_IN))))) | CARRY_IN);
endmodule

