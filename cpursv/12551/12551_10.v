
module half_sub_2(x,y,D,B);

  input  x,y;
  output D,B;

  assign D = y ^ x;
  assign B = ((y & x) ^ y) & ~x;
endmodule

