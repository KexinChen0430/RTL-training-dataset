
module _XOR_(A,B,Y);

  input  A,B;
  output Y;

  assign Y = (~A & B) | (((A & ~A) | ~B) & ((A & ~A) | A));
endmodule

