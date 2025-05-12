
module full_adder(cin,x,y,s,cout);

  input  cin;
  input  x;
  input  y;
  output s;
  output cout;

  assign s = (~((~x | (~y & (y | x))) & (x | (~x & y))) | ~cin) & ((cin & ~((~x | (~y & (y | x))) & (x | (~x & y)))) | ((~x | (~y & (y | x))) & (x | (~x & y))));
  assign cout = (cin & (y | (cin & x))) | ((cin | y) & x);
endmodule

