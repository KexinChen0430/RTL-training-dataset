
module full_sub_2(x,y,z,D,B);

  input  x,y,z;
  output D,B;

  assign D = (((~(~z & x) & ((~x & ~z) | y)) & y) & ~z) | ((z | (~z & (x & ~((~z & (z | y)) & y)))) & (~(((~y | y) & (~x | (~y & (~x | x)))) & (y | x)) | ((((~x | (~y & (~x | x))) & ~z) | ~(((~y | y) & (~x | (~y & (~x | x)))) & (y | x))) & (y | x))));
  assign B = (~x | y) & ((y & ~x) | z);
endmodule

