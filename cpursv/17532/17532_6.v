
module full_adder(cin,x,y,s,cout);

  input  cin;
  input  x;
  input  y;
  output s;
  output cout;

  assign s = ((cin & ~(y ^ x)) | ((~cin & y) & ~(((y | x) & ~cin) & x))) | ((x & ~(~cin & y)) & ~cin);
  assign cout = ((cin & y) | (x & y)) | (cin & x);
endmodule

