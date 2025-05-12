
module full_adder(cin,x,y,s,cout);

  input  cin;
  input  x;
  input  y;
  output s;
  output cout;

  assign s = ((cin & ~((y & ~x) | (x & (~x | ~y)))) | (~y & (x & ~cin))) | (y & (~cin & ~x));
  assign cout = ((((((y | x) & cin) | y) | cin) & (x | cin)) & y) | ((y | x) & cin);
endmodule

