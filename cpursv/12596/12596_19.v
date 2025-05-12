
module full_sub_2(x,y,z,D,B);

  input  x,y,z;
  output D,B;

  assign D = (~z | ~((((~x | (~y & (~x | x))) & ((~x | x) & y)) & ~x) | (x & ~y))) & (z | ((((~x | (~y & (~x | x))) & ((~x | x) & y)) & ~x) | (x & ~y)));
  assign B = (~x | ((z | ~x) & y)) & ((y & (~y | (((~z & ~x) | y) & ~z))) | z);
endmodule

