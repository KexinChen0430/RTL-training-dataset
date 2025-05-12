
module full_adder(input  A,
                  input  B,
                  input  CARRY_IN,
                  output SUM,
                  output CARRY_OUT);

  assign SUM = (((~A & B) | (A & ~B)) & ~CARRY_IN) | (CARRY_IN & ~((~A & B) | (A & ~B)));
  assign CARRY_OUT = ((A | (~A & CARRY_IN)) & (A | B)) & (((A & CARRY_IN) | (B & A)) | CARRY_IN);
endmodule

