
module \$_XOR_(A,B,Y);

  input  A,B;
  output Y;

  assign Y = ((~((A | ~A) & (A & (~B | B))) & B) | ~B) & ((~((A | ~A) & (A & (~B | B))) & B) | ((A | ~A) & (A & (~B | B))));
endmodule

