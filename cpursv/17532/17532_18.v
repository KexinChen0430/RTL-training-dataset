
module full_adder(cin,x,y,s,cout);

  input  cin;
  input  x;
  input  y;
  output s;
  output cout;

  assign s = ((y & ~(x & ((y | x) & ~cin))) & ~cin) | ((x & (~cin & ~(~cin & y))) | (cin & ~(((y | x) & ~x) | (~y & x))));
  assign cout = ((y | x) & cin) | (y & x);
endmodule

