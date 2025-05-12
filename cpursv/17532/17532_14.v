
module full_adder(cin,x,y,s,cout);

  input  cin;
  input  x;
  input  y;
  output s;
  output cout;

  assign s = (((~(y ^ x) & cin) | (y ^ x)) & ~cin) | (~(y ^ x) & cin);
  assign cout = (y | ((cin | y) & x)) & (((y | ((cin | y) & x)) | x) & (cin | x));
endmodule

