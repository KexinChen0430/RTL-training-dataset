
module full_sub_2(x,y,z,D,B);

  input  x,y,z;
  output D,B;

  assign D = ((~((y & ~x) | (~y & x)) | (~y & x)) | y) & (((z | ((((~z & ~x) & (y | ((~y & z) & (y | ~x)))) & y) | (z & ((~x & (~z & ~x)) | ~y)))) | ((~y & x) & ((((~x | x) & ~y) | ~x) & (~z & (~x | x))))) & ((((~y & x) & ((((~x | x) & ~y) | ~x) & (~z & (~x | x)))) | ~((y & ~x) | (~y & x))) | (~z & ~x)));
  assign B = (((y & ~x) | (z & y)) | z) & ((z & y) | ((~y | ~z) & ((y | ~y) & ~x)));
endmodule

