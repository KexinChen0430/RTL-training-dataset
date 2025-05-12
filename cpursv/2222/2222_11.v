
module full_adder(input  A,
                  input  B,
                  input  CARRY_IN,
                  output SUM,
                  output CARRY_OUT);

  assign SUM = (~CARRY_IN | (CARRY_IN & ~((((((A & (CARRY_IN | (~B & A))) & ~((CARRY_IN | (~B & A)) & B)) | (~(A & (CARRY_IN | (~B & A))) & ((CARRY_IN | (~B & A)) & B))) | B) & ~A) | (~B & A)))) & ((((((((A & (CARRY_IN | (~B & A))) & ~((CARRY_IN | (~B & A)) & B)) | (~(A & (CARRY_IN | (~B & A))) & ((CARRY_IN | (~B & A)) & B))) | B) & ~A) | (~B & A)) | CARRY_IN) & (~CARRY_IN | (CARRY_IN | (~B & A))));
  assign CARRY_OUT = (A & CARRY_IN) | ((B & A) | ((B & ~A) & (CARRY_IN | (B & A))));
endmodule

