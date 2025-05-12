
module full_sub_2(x,y,z,D,B);

  input  x,y,z;
  output D,B;

  assign D = (~(x ^ y) & z) | (~z & (((~(x ^ y) & z) | (~x & y)) | (((~x & y) | x) & ~y)));
  assign B = ((((((~z & (~x & y)) | (~y & z)) | z) & (y & (((~x & ~y) | (~x & ~z)) | z))) | (~x & ~y)) & z) | ((((~z & (~x & y)) | (~y & z)) | z) & (y & (((~x & ~y) | (~x & ~z)) | z)));
endmodule

