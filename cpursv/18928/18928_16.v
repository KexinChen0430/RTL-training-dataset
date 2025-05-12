
module _XOR_(A,B,Y);

  input  A,B;
  output Y;

  assign Y = (((B & ((A & ~(B & A)) | (~A & (B & A)))) | (~A & B)) | ((B | ~B) & A)) & (((A & ~(B & A)) | (~A & (B & A))) | ~A);
endmodule

