
module full_sub_2(x,y,z,D,B);

  input  x,y,z;
  output D,B;

  assign D = ((~y | ~x) & (((((y | ~x) & ~z) & y) | (x & (~z & ~y))) & (~(y ^ x) | ~z))) | (~(y ^ x) & ((~(y ^ x) | ~z) & z));
  assign B = ((y | ~x) & z) | (((((y & ((~y | ~x) & ((~x & ~z) | y))) & ~x) & (~x & z)) ^ ((y & ((~y | ~x) & ((~x & ~z) | y))) & ~x)) ^ (((~x & z) & ((~x & z) & (y | ~x))) ^ ((~x & z) & ((y & ((~y | ~x) & ((~x & ~z) | y))) & ~x))));
endmodule

