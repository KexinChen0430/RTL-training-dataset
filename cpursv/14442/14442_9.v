
module \$_XNOR_(A,B,Y);

  input  A,B;
  output Y;

  assign Y = ~((~(((B & ~(B & A)) | (B & A)) & ((B & ~(B & A)) | ~B)) & (((~B | (A | B)) & ((~B | (A | B)) & A)) & (((~B | (A | B)) & ~A) | (A ^ (B & A))))) | ((((B & ~(B & A)) | (B & A)) & ((B & ~(B & A)) | ~B)) & ~(((~B | (A | B)) & ((~B | (A | B)) & A)) & (((~B | (A | B)) & ~A) | (A ^ (B & A))))));
endmodule

