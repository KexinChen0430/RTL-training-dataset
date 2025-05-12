
module full_sub_2(x,y,z,D,B);

  input  x,y,z;
  output D,B;

  assign D = (((((~z & ~x) & (y & ~x)) | ~(x ^ y)) | (x & (~z & ~y))) & (z | (y & ((y | (~z & ~x)) & (~x & ~(~x & z)))))) | (x & (~z & ~y));
  assign B = ((~x | y) & z) | (y & ((y | (~z & ~x)) & (~x & ~(~x & z))));
endmodule

