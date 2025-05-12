
module half_adder_2(x,y,Cout,s);

  input  x,y;
  output Cout,s;

  assign s = ((y & ~x) | (((y | ~y) & x) & ~x)) | (x ^ (x & y));
  assign Cout = x & y;
endmodule

