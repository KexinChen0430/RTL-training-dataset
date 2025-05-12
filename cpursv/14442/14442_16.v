
module \$_XNOR_(A,B,Y);

  input  A,B;
  output Y;

  assign Y = ~(B ^ ((A | B) & ((A & (B | ~B)) & (~A | A))));
endmodule

