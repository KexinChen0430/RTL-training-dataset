
module half_adder_2(x,y,Cout,s);

  input  x,y;
  output Cout,s;

  assign s = ((((x & (~y | y)) & y) & y) ^ y) ^ ((y | x) & ((x & y) ^ x));
  assign Cout = x & y;
endmodule

