
module full_adder(input  A,
                  input  B,
                  input  CARRY_IN,
                  output SUM,
                  output CARRY_OUT);

  assign SUM = ((~CARRY_IN & A) & ~B) | ((CARRY_IN & ~((B & ~A) | (A & ~B))) | ((B & ~A) & ~CARRY_IN));
  assign CARRY_OUT = (A & B) | ((((A & ~B) | CARRY_IN) & (B | ((CARRY_IN & A) | (A & B)))) & CARRY_IN);
endmodule

