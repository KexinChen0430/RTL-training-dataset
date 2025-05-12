
module full_adder(cin,x,y,s,cout);

  input  cin;
  input  x;
  input  y;
  output s;
  output cout;

  assign s = (((y & ~cin) & ~x) | (cin & ~((~y & x) | (~x & ((y | (x & cin)) | x))))) | (~y & (x & ~cin));
  assign cout = ((x & y) | (y & cin)) | (x & cin);
endmodule

