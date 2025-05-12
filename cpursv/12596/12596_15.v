
module full_sub_2(x,y,z,D,B);

  input  x,y,z;
  output D,B;

  assign D = (y ^ x) ^ z;
  assign B = ((((~x & ~y) | ((y & ~x) | z)) & y) & ((y & ~x) | z)) | (~y & (z & (((((~x & ~y) | ((y & ~x) | z)) & y) & ((y & ~x) | z)) | ~x)));
endmodule

