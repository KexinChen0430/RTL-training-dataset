
module full_sub_2(x,y,z,D,B);

  input  x,y,z;
  output D,B;

  assign D = ((~z & ((((~z & ~x) | y) & ~x) | ~y)) | (((~z | ~((((x & ~y) | y) & ~x) | (~y & ((x & ~y) | y)))) & z) & ~((((x & ~y) | y) & ~x) | (~y & ((x & ~y) | y))))) & ((((~z | ~((((x & ~y) | y) & ~x) | (~y & ((x & ~y) | y)))) & z) & ~((((x & ~y) | y) & ~x) | (~y & ((x & ~y) | y)))) | ((x & ~y) | y));
  assign B = (z | (((~z & ~x) | (~y & ~x)) & (~z & y))) & (y | (z & ~x));
endmodule

