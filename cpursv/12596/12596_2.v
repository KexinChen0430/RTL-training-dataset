
module full_sub_2(x,y,z,D,B);

  input  x,y,z;
  output D,B;

  assign D = ((((y & ~x) | x) & ~y) | ((z & ~((~y & (y | x)) | ((y | x) & ~x))) | (y & ~x))) & (~((~y & (y | x)) | ((y | x) & ~x)) | ~z);
  assign B = ((y & z) | ((z & (~x & ((~z & y) | z))) & (~y | ~z))) | ((~x & ((~z & y) | z)) & (~y | (~z & (~x & ((~z & y) | z)))));
endmodule

