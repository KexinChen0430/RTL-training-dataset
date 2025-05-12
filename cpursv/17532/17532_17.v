
module full_adder(cin,x,y,s,cout);

  input  cin;
  input  x;
  input  y;
  output s;
  output cout;

  assign s = (cin & ~(y ^ x)) | ((((cin | ((y & ~cin) & ~x)) | (~cin & (x & ~y))) & ((((cin & ~(y ^ x)) | ~cin) & (((cin & ~(y ^ x)) | ~cin) & (((cin | ((y & ~cin) & ~x)) | (~cin & (x & ~y))) & (x & ~cin)))) & ((cin & ~(y ^ x)) | ~cin))) ^ (((cin | ((y & ~cin) & ~x)) | (~cin & (x & ~y))) & (((cin & ~(y ^ x)) | ~cin) & ((((cin & ~(y ^ x)) | ~cin) & ((y & ~cin) & ((cin | ((y & ~cin) & ~x)) | (~cin & (x & ~y))))) & ((cin & ~(y ^ x)) | ~cin)))));
  assign cout = (cin & (x | y)) | (x & y);
endmodule

