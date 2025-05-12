
module _XOR_(A,B,Y);

  input  A,B;
  output Y;

  assign Y = (((A & ~(A & B)) | ~A) & ((A & ~(A & B)) | (A & B))) | (~A & B);
endmodule

