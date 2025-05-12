
module full_adder(cin,x,y,s,cout);

  input  cin;
  input  x;
  input  y;
  output s;
  output cout;

  assign s = (((~((~y | (~x & y)) & (y | x)) | ~cin) & y) ^ (x & (~((~y | (~x & y)) & (y | x)) | ~cin))) | (~((~y | (~x & y)) & (y | x)) & cin);
  assign cout = ((x & cin) | y) & ((y | x) & (x | cin));
endmodule

