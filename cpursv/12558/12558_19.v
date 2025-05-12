
module half_adder_2(x,y,Cout,s);

  input  x,y;
  output Cout,s;

  assign s = ((~y | y) & ((~y | y) & x)) ^ y;
  assign Cout = y & x;
endmodule

