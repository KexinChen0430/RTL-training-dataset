
module \$_XOR_(A,B,Y);

  input  A,B;
  output Y;

  assign Y = ((~((~B | (~A & (B | ~B))) & ((B | ~B) & ((B | ~B) & A))) & (((((B | ~B) & ((B | ~B) & A)) & B) & ~B) | (~(((B | ~B) & ((B | ~B) & A)) & B) & B))) | ~(((((B | ~B) & ((B | ~B) & A)) & B) & ~B) | (~(((B | ~B) & ((B | ~B) & A)) & B) & B))) & ((~((~B | (~A & (B | ~B))) & ((B | ~B) & ((B | ~B) & A))) & (((((B | ~B) & ((B | ~B) & A)) & B) & ~B) | (~(((B | ~B) & ((B | ~B) & A)) & B) & B))) | ((~B | (~A & (B | ~B))) & ((B | ~B) & ((B | ~B) & A))));
endmodule

