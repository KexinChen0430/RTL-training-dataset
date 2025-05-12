
module half_sub_2(x,y,D,B);

  input  x,y;
  output D,B;

  assign D = (y ^ (y & x)) | ((x ^ (y & x)) & ~y);
  assign B = ~x & (y ^ (y & x));
endmodule

