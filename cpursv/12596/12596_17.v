
module full_sub_2(x,y,z,D,B);

  input  x,y,z;
  output D,B;

  assign D = (((~y | ~x) & x) | (z | (~x & y))) & ((~z & (x & ~y)) | (~((y & (~y | ~x)) | (x & ~y)) | (((y & (~z & (y | z))) & (~x & (z & (~x | y)))) ^ ((y & (~z & (y | z))) & (~x & y)))));
  assign B = (y | z) & (((((~x | y) & ~z) | ~y) & (~x & (~y | y))) | (z & y));
endmodule

