
module full_adder(input  A,
                  input  B,
                  input  CARRY_IN,
                  output SUM,
                  output CARRY_OUT);

  assign SUM = ((CARRY_IN | (B ^ A)) & (~CARRY_IN | (CARRY_IN | A))) & ((~(B ^ A) | (~CARRY_IN & (~A & B))) | ((~CARRY_IN & A) & ~B));
  assign CARRY_OUT = (((~A & CARRY_IN) | (((((CARRY_IN | A) & (CARRY_IN | ~B)) & (((A & (CARRY_IN | (~A & B))) & ~B) & (CARRY_IN & A))) ^ (((CARRY_IN | A) & (CARRY_IN | ~B)) & ((~B & (B & (CARRY_IN | (~A & B)))) & (CARRY_IN & A)))) | (A & B))) & B) | ((((CARRY_IN | (~A & B)) & (CARRY_IN & (B & (CARRY_IN | (~A & B))))) & ~((CARRY_IN | (~A & B)) & (CARRY_IN & (A & (CARRY_IN | (~A & B)))))) | (~((CARRY_IN | (~A & B)) & (CARRY_IN & (B & (CARRY_IN | (~A & B))))) & ((CARRY_IN | (~A & B)) & (CARRY_IN & (A & (CARRY_IN | (~A & B)))))));
endmodule

