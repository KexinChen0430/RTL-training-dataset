
module full_adder(cin,x,y,s,cout);

  input  cin;
  input  x;
  input  y;
  output s;
  output cout;

  assign s = (~(((~x & y) | ~y) & (x | (~x & y))) | ~cin) & ((~(((~x & y) | ~y) & (x | (~x & y))) & cin) | (((~x & y) | ~y) & (x | (~x & y))));
  assign cout = (cin | (x & y)) & (x | y);
endmodule

