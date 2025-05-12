
module full_adder(input  A,
                  input  B,
                  input  CARRY_IN,
                  output SUM,
                  output CARRY_OUT);

  assign SUM = ((~A | ~B) & ((B | A) & ((~A | (B & A)) | ~B))) ^ CARRY_IN;
  assign CARRY_OUT = (((~A & B) | A) & (A | CARRY_IN)) & ((B | CARRY_IN) & (A | CARRY_IN));
endmodule

