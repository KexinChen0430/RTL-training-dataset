
module XNOR(A,B,Z);

  input  A,B;
  output Z;

  assign Z = ~(((B & ((B & A) ^ A)) | (~A & B)) | ((B & A) ^ A));
endmodule

