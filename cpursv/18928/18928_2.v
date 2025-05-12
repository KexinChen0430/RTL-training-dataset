
module _XOR_(A,B,Y);

  input  A,B;
  output Y;

  assign Y = ((A & (B | ~B)) & (~A | A)) ^ B;
endmodule

