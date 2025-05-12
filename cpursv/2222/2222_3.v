
module full_adder(input  A,
                  input  B,
                  input  CARRY_IN,
                  output SUM,
                  output CARRY_OUT);

  assign SUM = (~(A ^ B) & CARRY_IN) | ((B & ~CARRY_IN) ^ (A & ~CARRY_IN));
  assign CARRY_OUT = (CARRY_IN & (((A ^ B) | (B & A)) & ((B & A) | (CARRY_IN | (~A & B))))) | ((B & A) | (CARRY_IN & (A & ((~B | CARRY_IN) & (A | CARRY_IN)))));
endmodule

