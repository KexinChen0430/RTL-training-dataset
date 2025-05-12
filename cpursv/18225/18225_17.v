
module XOR(A,B,Z);

  input  A,B;
  output Z;

  assign Z = (A ^ (B & A)) | ((~A & (A & (~B | (B | (A ^ (B & A)))))) ^ (~A & B));
endmodule

