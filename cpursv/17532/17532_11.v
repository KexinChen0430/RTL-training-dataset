
module full_adder(cin,x,y,s,cout);

  input  cin;
  input  x;
  input  y;
  output s;
  output cout;

  assign s = ((~cin & (~y & x)) | (~((~x | ~y) & (x | ((cin & x) | y))) | (~cin & (y & ~x)))) & (((~(y & ~cin) & (x & ~cin)) | cin) | (~(x & ~cin) & (y & ~cin)));
  assign cout = ((cin & x) | (x & y)) | (cin & y);
endmodule

