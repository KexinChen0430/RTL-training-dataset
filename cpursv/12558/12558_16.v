
module half_adder_2(x,y,Cout,s);

  input  x,y;
  output Cout,s;

  assign s = y ^ (x & (~y | y));
  assign Cout = x & y;
endmodule

