
module full_sub_2(x,y,z,D,B);

  input  x,y,z;
  output D,B;

  assign D = (((x & ~y) & (~(((y | (x & ~y)) & ~x) | (~y & (y | (x & ~y)))) | ~z)) | ((~(((y | (x & ~y)) & ~x) | (~y & (y | (x & ~y)))) | ~z) & ((((y | (~z & ~x)) & ~x) & y) | ((x & ~y) & y)))) | (z & ~(((y | (x & ~y)) & ~x) | (~y & (y | (x & ~y)))));
  assign B = (((~z & y) & (((y | (~z & ~x)) & ~x) & y)) ^ ((~z & y) & ((y | ~x) & (~x & z)))) | ((y | ~x) & z);
endmodule

