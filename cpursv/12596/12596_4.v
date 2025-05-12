
module full_sub_2(x,y,z,D,B);

  input  x,y,z;
  output D,B;

  assign D = (((y & ((~x & ~z) & ~x)) | ~((~x & (y | x)) | (~y & (y | x)))) & (((((~x & ~z) | z) & y) | z) | (~y & x))) | (~z & (~y & x));
  assign B = (y & z) | (~x & (z | y));
endmodule

