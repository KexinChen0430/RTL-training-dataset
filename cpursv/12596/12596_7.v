
module full_sub_2(x,y,z,D,B);

  input  x,y,z;
  output D,B;

  assign D = ((((((~y & (~z & x)) | ~(((~y & (x | ~x)) | ~x) & (y | x))) | (~x & ~z)) & z) & (~(((~y & (x | ~x)) | ~x) & (y | x)) | (y | x))) | (y & (~x & ~z))) | (~y & (~z & x));
  assign B = (z & ((y | (~y & ~x)) & (z | y))) | ((~x & y) & (~(z & ~x) & ((y | (~y & ~x)) & (z | y))));
endmodule

