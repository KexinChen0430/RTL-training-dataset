
module \$_XOR_(A,B,Y);

  input  A,B;
  output Y;

  assign Y = ((B | ~B) & ((B | ~B) & A)) ^ B;
endmodule

