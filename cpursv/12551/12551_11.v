
module half_sub_2(x,y,D,B);

  input  x,y;
  output D,B;

  assign D = (~x | ~y) & ((((~x & (y & x)) | ~(y & x)) & ((~x & (y & x)) | x)) | y);
  assign B = ~x & (y & (~x | ~y));
endmodule

