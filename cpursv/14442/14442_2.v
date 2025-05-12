
module \$_XNOR_(A,B,Y);

  input  A,B;
  output Y;

  assign Y = ~((((((~B | B) & A) & B) & B) ^ B) ^ (((A & ~A) | A) & ((A & ~A) | ~B)));
endmodule

