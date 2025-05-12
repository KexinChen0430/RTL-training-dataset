
module _XOR_(A,B,Y);

  input  A,B;
  output Y;

  assign Y = ((~A & B) | (A & (~B | B))) & (~B | ~A);
endmodule

