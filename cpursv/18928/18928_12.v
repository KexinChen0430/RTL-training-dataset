
module _XOR_(A,B,Y);

  input  A,B;
  output Y;

  assign Y = ((B | ~B) & (A & (B | ~B))) ^ B;
endmodule

