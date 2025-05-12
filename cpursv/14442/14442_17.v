
module \$_XNOR_(A,B,Y);

  input  A,B;
  output Y;

  assign Y = ~((~A | ~B) & ((((B & ~B) | B) & ((B & ~B) | ~A)) | (A | B)));
endmodule

