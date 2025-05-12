
module half_adder_2(x,y,Cout,s);

  input  x,y;
  output Cout,s;

  assign s = ((~y & ((y | x) & ((((y | x) | ~y) & x) & (~x | x)))) | y) & ((~y & ((y | x) & ((((y | x) | ~y) & x) & (~x | x)))) | ~((y | x) & ((((y | x) | ~y) & x) & (~x | x))));
  assign Cout = y & x;
endmodule

