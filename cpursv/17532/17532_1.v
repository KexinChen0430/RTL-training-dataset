
module full_adder(cin,x,y,s,cout);

  input  cin;
  input  x;
  input  y;
  output s;
  output cout;

  assign s = (((((~y & (x & ~cin)) | (((~x & ~cin) & y) | cin)) & (~cin & y)) & ((~y & (x & ~cin)) | (((~x & ~cin) & y) | cin))) ^ (((~y & (x & ~cin)) | (((~x & ~cin) & y) | cin)) & ((x & ~cin) & ((~y & (x & ~cin)) | (((~x & ~cin) & y) | cin))))) | (~(((~x | (~y & x)) & y) | (~y & x)) & cin);
  assign cout = ((cin & y) | (x & y)) | ((cin & x) | (x & y));
endmodule

