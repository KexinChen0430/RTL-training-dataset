
module half_sub_2(x,y,D,B);

  input  x,y;
  output D,B;

  assign D = (~y & ((x & y) ^ x)) | (((y & ~x) | ((~y & y) | ~x)) & y);
  assign B = y & ~x;
endmodule

