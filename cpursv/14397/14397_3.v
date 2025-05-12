
module \$_XOR_(A,B,Y);

  input  A,B;
  output Y;

  assign Y = (((~A & A) | A) & ((~A & A) | ~B)) | (((B & ~A) | ((B | ~B) & A)) & ~A);
endmodule

