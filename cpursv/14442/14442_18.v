
module \$_XNOR_(A,B,Y);

  input  A,B;
  output Y;

  assign Y = ~((((~(~B & ((~A | A) & (A & (~B | B)))) & (B & ~B)) | (~(B & ~B) & (~B & ((~A | A) & (A & (~B | B)))))) | (~A | ~B)) & ((A & (~A | ~B)) | B));
endmodule

