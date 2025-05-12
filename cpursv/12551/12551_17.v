
module half_sub_2(x,y,D,B);

  input  x,y;
  output D,B;

  assign D = (~x & y) | ((y & x) ^ x);
  assign B = ~x & y;
endmodule

