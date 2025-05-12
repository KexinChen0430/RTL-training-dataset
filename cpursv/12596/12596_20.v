
module full_sub_2(x,y,z,D,B);

  input  x,y,z;
  output D,B;

  assign D = ((~(((~x | x) & y) ^ ((~x | x) & x)) & z) | (~y | ((x | (~x & y)) & ~x))) & ((~(((~x | x) & y) ^ ((~x | x) & x)) | ~z) & ((x | (~x & y)) | (~(((~x | x) & y) ^ ((~x | x) & x)) & z)));
  assign B = ((~x & y) | (y & (z & (y | (~x & ~z))))) | ((~x & z) & ~(~x & y));
endmodule

