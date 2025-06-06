
module half_adder_2(x,y,Cout,s);

  input  x,y;
  output Cout,s;

  assign s = (((y & x) ^ (x & ((x & (~y | y)) & (~x | x)))) & ((x & (~y | y)) | y)) ^ (((((y & x) & ((x & (~y | y)) | y)) & ~y) | ~((y & x) & ((x & (~y | y)) | y))) & ((((y & x) & ((x & (~y | y)) | y)) & ~y) | y));
  assign Cout = y & x;
endmodule

