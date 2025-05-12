
module full_adder(input  A,
                  input  B,
                  input  CARRY_IN,
                  output SUM,
                  output CARRY_OUT);

  assign SUM = CARRY_IN ^ (B ^ A);
  assign CARRY_OUT = (B & A) | (((A | (B & ~A)) & ((A & (CARRY_IN | (B & ~A))) & CARRY_IN)) ^ ((A | (B & ~A)) & (CARRY_IN & (B & (CARRY_IN | (B & ~A))))));
endmodule

