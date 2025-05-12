
module full_adder(cin,x,y,s,cout);

  input  cin;
  input  x;
  input  y;
  output s;
  output cout;

  assign s = ((((~cin | ~((x | y) & (~y | (y & ~x)))) & (((~cin | ~((x | y) & (~y | (y & ~x)))) & (((cin | ((y & ~x) & ~cin)) | (~y & (~cin & x))) & (~cin & x))) & (~cin | ~((x | y) & (~y | (y & ~x)))))) & (~cin | ~((x | y) & (~y | (y & ~x))))) ^ ((~cin | ~((x | y) & (~y | (y & ~x)))) & (((~cin | ~((x | y) & (~y | (y & ~x)))) & ((~cin | ~((x | y) & (~y | (y & ~x)))) & (((cin | ((y & ~x) & ~cin)) | (~y & (~cin & x))) & (y & ~cin)))) & (~cin | ~((x | y) & (~y | (y & ~x))))))) | (cin & (~cin | ~((x | y) & (~y | (y & ~x)))));
  assign cout = (y & x) | ((cin & y) | (cin & x));
endmodule

