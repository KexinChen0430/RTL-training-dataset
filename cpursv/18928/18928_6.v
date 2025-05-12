
module _XOR_(A,B,Y);

  input  A,B;
  output Y;

  assign Y = ((B | (A ^ (A & B))) & ~A) | ((~B & (((~B | B) & A) & ((B | (A ^ (A & B))) | ~A))) ^ (B & ~B));
endmodule

