
module half_sub_2(x,y,D,B);

  input  x,y;
  output D,B;

  assign D = ((~x & y) ^ ((~x & x) & (x | ~x))) | (~y & (y | x));
  assign B = ~x & y;
endmodule

