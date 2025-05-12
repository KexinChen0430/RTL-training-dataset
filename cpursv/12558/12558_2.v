
module half_adder_2(x,y,Cout,s);

  input  x,y;
  output Cout,s;

  assign s = y ^ ((x & (((((~(x & y) & x) | ~x) & ((~(x & y) & x) | (x & y))) | ~x) | y)) & (((((~(x & y) & x) | ~x) & ((~(x & y) & x) | (x & y))) | ~x) | y));
  assign Cout = x & y;
endmodule

