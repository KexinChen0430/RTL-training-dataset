
module full_adder(cin,x,y,s,cout);

  input  cin;
  input  x;
  input  y;
  output s;
  output cout;

  assign s = ((~cin & y) & ~(x & ~cin)) | (((~cin & ~(~cin & y)) & x) | (cin & ~(((~y | (~x & y)) & x) | (~x & y))));
  assign cout = ((x & y) | (cin & y)) | (cin & x);
endmodule

