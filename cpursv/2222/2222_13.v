
module full_adder(input  A,
                  input  B,
                  input  CARRY_IN,
                  output SUM,
                  output CARRY_OUT);

  assign SUM = ((CARRY_IN | (~(B & ~CARRY_IN) & (~CARRY_IN & A))) | (~(~CARRY_IN & A) & (B & ~CARRY_IN))) & ((~(B & ~CARRY_IN) & (~CARRY_IN & A)) | ((~(~CARRY_IN & A) & (B & ~CARRY_IN)) | ~(A ^ B)));
  assign CARRY_OUT = (((CARRY_IN | (B & ~A)) & (CARRY_IN & ((CARRY_IN | (B & ~A)) & B))) ^ ((CARRY_IN | (B & ~A)) & (((CARRY_IN | (B & ~A)) & A) & CARRY_IN))) | ((B & A) | (CARRY_IN & (A & ((((~B | ~A) & A) & ~B) | CARRY_IN))));
endmodule

