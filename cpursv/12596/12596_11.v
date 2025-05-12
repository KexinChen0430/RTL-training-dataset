
module full_sub_2(x,y,z,D,B);

  input  x,y,z;
  output D,B;

  assign D = (((~(((y | (~y & x)) & ~x) | (~y & x)) | (~y & x)) | ((y | (~y & x)) & ~x)) & (((y | (~y & x)) & ~x) | (~y & x))) ^ (z & ((~(((y | (~y & x)) & ~x) | (~y & x)) | (~y & x)) | ((y | (~y & x)) & ~x)));
  assign B = ((y & ((~x & ~z) | (~x & ~y))) | (((((~x & (~x & y)) & ~z) | z) & (~x & ~y)) & z)) | ((y & (z | ~x)) & (((~y & z) & (~x | y)) | y));
endmodule

