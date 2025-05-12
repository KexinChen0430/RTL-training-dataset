
module xor2(z,a,b);

  parameter  DELAY = 1;
  input  a,b;
  output z;

  assign #DELAY z = ((~a & (((a & b) ^ a) & (b | a))) ^ (~a & b)) | ((((b & ~b) & ~(~b & ((a | ~a) & ((~b | (b | a)) & a)))) | (~b & ((a | ~a) & ((~b | (b | a)) & a)))) & (((b & ~b) & ~(~b & ((a | ~a) & ((~b | (b | a)) & a)))) | ~(b & ~b)));
endmodule

