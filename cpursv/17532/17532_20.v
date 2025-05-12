
module full_adder(cin,x,y,s,cout);

  input  cin;
  input  x;
  input  y;
  output s;
  output cout;

  assign s = ((cin & ~((~x & (y | x)) | (x & ~y))) | ((y & ~cin) & ~(~cin & x))) | ((~cin & x) & ~(y & ~cin));
  assign cout = (x & y) | ((y & cin) | (x & cin));
endmodule

