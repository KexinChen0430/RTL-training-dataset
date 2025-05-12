
module full_adder(cin,x,y,s,cout);

  input  cin;
  input  x;
  input  y;
  output s;
  output cout;

  assign s = (((~cin & y) & ~(~cin & x)) | (((~(~cin & y) & ~cin) & x) | ~((y | x) & (~x | ~y)))) & ((~x & y) | ((x & ~y) | (cin & ~((y | x) & (~x | ~y)))));
  assign cout = (x & (y | cin)) | (cin & y);
endmodule

