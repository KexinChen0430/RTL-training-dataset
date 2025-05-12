
module full_sub_2(x,y,z,D,B);

  input  x,y,z;
  output D,B;

  assign D = (~(x ^ y) & z) | ((~z & x) ^ (y & ~z));
  assign B = (((~x | y) | ~y) & ((z & y) | ~x)) & (y | ((~z & z) | (z & ~y)));
endmodule

