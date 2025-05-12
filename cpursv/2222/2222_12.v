
module full_adder(input  A,
                  input  B,
                  input  CARRY_IN,
                  output SUM,
                  output CARRY_OUT);

  assign SUM = ((((((((CARRY_IN | (~A & B)) & A) & (CARRY_IN & ~B)) & A) ^ (A & ((CARRY_IN & ~B) & (B & (CARRY_IN | (~A & B)))))) | ((B | (A & ~B)) & (~CARRY_IN & (~B | ~A)))) | CARRY_IN) & ~((~A & B) | (A & ~B))) | ((B | (A & ~B)) & (~CARRY_IN & (~B | ~A)));
  assign CARRY_OUT = ((((A & CARRY_IN) & (~A & B)) ^ ((CARRY_IN & (B & ((A & ~B) | CARRY_IN))) & (~A & B))) | (A & CARRY_IN)) | (B & A);
endmodule

