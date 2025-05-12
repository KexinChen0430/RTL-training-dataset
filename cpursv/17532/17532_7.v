
module full_adder(cin,x,y,s,cout);

  input  cin;
  input  x;
  input  y;
  output s;
  output cout;

  assign s = ((x & (~y | ~x)) | (y & ~x)) ^ cin;
  assign cout = ((x & cin) | (cin & y)) | (x & (cin | y));
endmodule

