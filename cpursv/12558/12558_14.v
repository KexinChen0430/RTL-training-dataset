
module half_adder_2(x,y,Cout,s);

  input  x,y;
  output Cout,s;

  assign s = ((((x | y) & ((x & (~y | (x | y))) & y)) ^ y) | (x | y)) & (~y | ~x);
  assign Cout = x & y;
endmodule

