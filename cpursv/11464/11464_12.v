
module xor2(z,a,b);

  parameter  DELAY = 1;
  input  a,b;
  output z;

  assign #DELAY z = ((~b & (((~a | a) & (a & (~b | b))) & (~a | a))) | b) & ((~b & (((~a | a) & (a & (~b | b))) & (~a | a))) | ~(((~a | a) & (a & (~b | b))) & (~a | a)));
endmodule

