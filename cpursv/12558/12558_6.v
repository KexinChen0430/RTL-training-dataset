
module half_adder_2(x,y,Cout,s);

  input  x,y;
  output Cout,s;

  assign s = (((x | y) & ((x & ~(y & x)) | ((y & x) & ~x))) | (~x & ((((x & ~(y & x)) | ((y & x) & ~x)) | ~x) | y))) & (((x | y) & ((x & ~(y & x)) | ((y & x) & ~x))) | (x | y));
  assign Cout = y & x;
endmodule

