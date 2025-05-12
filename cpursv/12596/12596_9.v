
module full_sub_2(x,y,z,D,B);

  input  x,y,z;
  output D,B;

  assign D = (((~y & (x & ~z)) | z) | (~z & (y & ~x))) & (~z | ~(((~y | ~x) & (z | ~z)) & (x | y)));
  assign B = (y & ((y & ~x) | z)) | ((y & ~x) ^ (((y | ((y & ~x) | z)) & (~x | y)) & ((z & ~x) & (~x | y))));
endmodule

