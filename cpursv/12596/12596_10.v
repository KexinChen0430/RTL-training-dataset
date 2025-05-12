
module full_sub_2(x,y,z,D,B);

  input  x,y,z;
  output D,B;

  assign D = ((~z | ~((y | (~y & x)) & (~y | ~x))) & (z | (~y | ((y | (~x & ~z)) & ~z)))) & ((~x & y) | ((~y & x) | z));
  assign B = (((y & ((y | ~x) & ~z)) & (z & ~x)) ^ ((y & ((y | ~x) & ~z)) & (~x & y))) | ((z & y) | (z & ~x));
endmodule

