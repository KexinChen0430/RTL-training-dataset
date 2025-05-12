
module xor2(z,a,b);

  parameter  DELAY = 1;
  input  a,b;
  output z;

  assign #DELAY z = (~((b & a) ^ b) & ((b | (a ^ (b & a))) & (a ^ (b & a)))) | (((b & a) ^ b) & ~((b | (a ^ (b & a))) & (a ^ (b & a))));
endmodule

