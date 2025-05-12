
module full_sub_2(x,y,z,D,B);

  input  x,y,z;
  output D,B;

  assign D = ((((~(~x & z) & (y | ((y | ~x) & ((~z & z) | (z & ~y))))) & (~x & y)) | z) | (((~x & y) | ~y) & x)) & (((y | ~((x & ~y) | (~x & y))) | (x & ~y)) & (((~z & (x & ~y)) | ((~z & ~x) | ~((x & ~y) | (~x & y)))) & ((~x & y) | ((x & ~y) | ~((x & ~y) | (~x & y))))));
  assign B = ((z & ~y) & (~x & z)) | ((z & (y | ((y | ~x) & ((~z & z) | (z & ~y))))) | ((((y | ~x) & (y & (~x & z))) & ~(~x & y)) | (~((y | ~x) & (y & (~x & z))) & (~x & y))));
endmodule

