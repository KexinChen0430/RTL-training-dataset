
module XOR(A,B,Z);

  input  A,B;
  output Z;

  assign Z = ((~B | (B | (A ^ (B & A)))) & (((~B | (B | (A ^ (B & A)))) & A) & (~B | (B | (A ^ (B & A)))))) ^ B;
endmodule

