
module half_sub_2(x,y,D,B);

  input  x,y;
  output D,B;

  assign D = ((x & y) ^ x) ^ (((~x | ~y) & (~x | y)) & y);
  assign B = y & ~x;
endmodule

