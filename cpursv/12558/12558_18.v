
module half_adder_2(x,y,Cout,s);

  input  x,y;
  output Cout,s;

  assign s = ((~y & ((~x | (x | ((((~y | y) & x) & y) ^ y))) & ((~y | y) & x))) | y) & ((~y & ((~x | (x | ((((~y | y) & x) & y) ^ y))) & ((~y | y) & x))) | ~((~x | (x | ((((~y | y) & x) & y) ^ y))) & ((~y | y) & x)));
  assign Cout = x & y;
endmodule

