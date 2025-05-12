
module XOR(A,B,Z);

  input  A,B;
  output Z;

  assign Z = (~B & ((~A & B) | A)) | (~A & B);
endmodule

