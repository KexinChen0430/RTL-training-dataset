
module full_adder(cin,x,y,s,cout);

  input  cin;
  input  x;
  input  y;
  output s;
  output cout;

  assign s = (~((x & (~x | ~y)) | (~x & y)) & cin) | (~cin & (((x | (~x & y)) | (~((x & (~x | ~y)) | (~x & y)) & cin)) & ((~x | ~y) | (~((x & (~x | ~y)) | (~x & y)) & cin))));
  assign cout = ((cin | y) & x) | (y & cin);
endmodule

