
module full_adder(input  A,
                  input  B,
                  input  CARRY_IN,
                  output SUM,
                  output CARRY_OUT);

  assign SUM = (((~CARRY_IN & (~(A & ~CARRY_IN) & B)) | (CARRY_IN | ((~CARRY_IN & ~(B & ~CARRY_IN)) & A))) & ~((A & ~B) | (B & ~A))) | ((((~CARRY_IN & (~(A & ~CARRY_IN) & B)) | (CARRY_IN | ((~CARRY_IN & ~(B & ~CARRY_IN)) & A))) & ((~((A & ~B) | (B & ~A)) | ~CARRY_IN) & (B & ~CARRY_IN))) ^ (((A & ~CARRY_IN) & (~((A & ~B) | (B & ~A)) | ~CARRY_IN)) & ((~CARRY_IN & (~(A & ~CARRY_IN) & B)) | (CARRY_IN | ((~CARRY_IN & ~(B & ~CARRY_IN)) & A)))));
  assign CARRY_OUT = ((CARRY_IN | A) & (A | (B & ~A))) & (((~B | (~A & CARRY_IN)) | B) & ((CARRY_IN & ((CARRY_IN | A) & (A | (B & ~A)))) | B));
endmodule

