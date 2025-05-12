
module xor2(z,a,b);

  parameter  DELAY = 1;
  input  a,b;
  output z;

  assign #DELAY z = ((b & ~((b | ~b) & (a & (b | ~b)))) | ((b | ~b) & (a & (b | ~b)))) & ((b & ~((b | ~b) & (a & (b | ~b)))) | ~b);
endmodule

