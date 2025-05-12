
module half_sub_2(x,y,D,B);

  input  x,y;
  output D,B;

  assign D = (x & ~y) | (((y & x) & (~x | x)) ^ y);
  assign B = ~x & (((y & x) & (~x | x)) ^ y);
endmodule

