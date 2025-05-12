
module full_adder(input  A,
                  input  B,
                  input  CARRY_IN,
                  output SUM,
                  output CARRY_OUT);

  assign SUM = (((~B & A) | (CARRY_IN & ~(((~B | ~A) & A) | (B & ~A)))) | (B & ~A)) & ((CARRY_IN & ~(((~B | ~A) & A) | (B & ~A))) | ~CARRY_IN);
  assign CARRY_OUT = (CARRY_IN & (((CARRY_IN & ~A) | A) & (B | A))) | ((A & ((B | (A | (B & ~A))) & (((CARRY_IN | (B & ~A)) & (~B | ~A)) | B))) & B);
endmodule

