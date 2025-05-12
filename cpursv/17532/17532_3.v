
module full_adder(cin,x,y,s,cout);

  input  cin;
  input  x;
  input  y;
  output s;
  output cout;

  assign s = ((cin | ((~x | ((x | y) & ~y)) & ~cin)) & (cin | (x | y))) & (~cin | (cin & ~(x ^ y)));
  assign cout = (y & x) | (cin & (x | y));
endmodule

