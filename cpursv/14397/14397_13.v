
module \$_XOR_(A,B,Y);

  input  A,B;
  output Y;

  assign Y = ((((A & B) ^ A) & B) | (B & ~A)) | (((((~B & ((~B | B) & A)) & ~(B & ~B)) | ~(~B & ((~B | B) & A))) & (((~B & ((~B | B) & A)) & ~(B & ~B)) | (B & ~B))) & ((A & B) ^ A));
endmodule

