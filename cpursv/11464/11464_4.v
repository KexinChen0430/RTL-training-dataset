
module xor2(z,a,b);

  parameter  DELAY = 1;
  input  a,b;
  output z;

  assign #DELAY z = (~b & (a ^ (a & b))) | ((~a & ((a & b) ^ b)) | ((((~(~b & (a & (b | ~b))) & (b & ~b)) | (~b & (a & (b | ~b)))) & ((~(~b & (a & (b | ~b))) & (b & ~b)) | ~(b & ~b))) & ~a));
endmodule

