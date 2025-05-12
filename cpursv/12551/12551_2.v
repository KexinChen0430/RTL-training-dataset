
module half_sub_2(x,y,D,B);

  input  x,y;
  output D,B;

  assign D = ((((y & ~y) & x) | ~y) & (((y & ~y) & x) | (x ^ (y & x)))) | ((((y & (x ^ (y & x))) | y) & ((y & (x ^ (y & x))) | ~x)) & ~x);
  assign B = (((y & (x ^ (y & x))) | y) & ((y & (x ^ (y & x))) | ~x)) & ~x;
endmodule

