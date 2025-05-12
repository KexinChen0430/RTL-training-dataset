
module full_adder(input  A,
                  input  B,
                  input  CARRY_IN,
                  output SUM,
                  output CARRY_OUT);

  assign SUM = (B ^ A) ^ CARRY_IN;
  assign CARRY_OUT = ((B & A) | (((CARRY_IN | (A & ~B)) & B) & CARRY_IN)) | (A & CARRY_IN);
endmodule

