
module full_adder(cin,x,y,s,cout);

  input  cin;
  input  x;
  input  y;
  output s;
  output cout;

  assign s = ((~(((x & (~y & (((cin & x) | y) | x))) | ~x) & (((cin & x) | y) | x)) | ((~cin & ~(x & ~cin)) & y)) | ((x & ~cin) & ~(y & ~cin))) & (((cin & ~(((x & (~y & (((cin & x) | y) | x))) | ~x) & (((cin & x) | y) | x))) | (x & (~y & (((cin & x) | y) | x)))) | (y & ((x & (~y & (((cin & x) | y) | x))) | ~x)));
  assign cout = ((cin & x) | y) & ((y & x) | cin);
endmodule

