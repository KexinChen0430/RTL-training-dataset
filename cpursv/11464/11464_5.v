
module xor2(z,a,b);

  parameter  DELAY = 1;
  input  a,b;
  output z;

  assign #DELAY z = (((((a ^ (b & a)) | ~a) & (((~b | b) & a) & (~b | b))) & ~(((b & ~(b & a)) | (b & (a ^ (b & a)))) & ((b & ~(b & a)) | ~b))) | ~(((a ^ (b & a)) | ~a) & (((~b | b) & a) & (~b | b)))) & (((((a ^ (b & a)) | ~a) & (((~b | b) & a) & (~b | b))) & ~(((b & ~(b & a)) | (b & (a ^ (b & a)))) & ((b & ~(b & a)) | ~b))) | (((b & ~(b & a)) | (b & (a ^ (b & a)))) & ((b & ~(b & a)) | ~b)));
endmodule

