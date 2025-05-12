
module full_sub_2(x,y,z,D,B);

  input  x,y,z;
  output D,B;

  assign D = (x & (~(~z & y) & ~z)) | ((~(x ^ y) & z) | ((((y | ~x) & ~(~z & x)) & y) & ~z));
  assign B = (~(~x & y) & (~x & z)) | ((((~z & y) & ((y | ~x) & (~x & z))) ^ ((~z & y) & (~x & y))) | (z & y));
endmodule

