
module _XOR_(A,B,Y);

  input  A,B;
  output Y;

  assign Y = ((B | A) & ((A & (~B | (B | A))) & (A | ~A))) ^ B;
endmodule

