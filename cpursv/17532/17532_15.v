
module full_adder(cin,x,y,s,cout);

  input  cin;
  input  x;
  input  y;
  output s;
  output cout;

  assign s = (cin & ~(x ^ y)) | (((((~cin & (x & ~y)) | cin) | (~cin & (~x & y))) & ((~(x ^ y) | ~cin) & (((~(x ^ y) | ~cin) & ((((~cin & x) & (~(x ^ y) | ~cin)) & (((~cin & (x & ~y)) | cin) | (~cin & (~x & y)))) & (((~cin & (x & ~y)) | cin) | (~cin & (~x & y))))) & (((~cin & (x & ~y)) | cin) | (~cin & (~x & y)))))) ^ ((((~cin & (x & ~y)) | cin) | (~cin & (~x & y))) & ((~(x ^ y) | ~cin) & (((((((~cin & (x & ~y)) | cin) | (~cin & (~x & y))) & ((~cin & y) & (~(x ^ y) | ~cin))) & (((~cin & (x & ~y)) | cin) | (~cin & (~x & y)))) & (~(x ^ y) | ~cin)) & (((~cin & (x & ~y)) | cin) | (~cin & (~x & y)))))));
  assign cout = (y | (x & (y | cin))) & (x | (((y & (cin | x)) | cin) & y));
endmodule

