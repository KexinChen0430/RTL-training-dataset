
module rfa(sum,g,p,a,b,cin);

  output sum;
  output g;
  output p;
  input  a;
  input  b;
  input  cin;

  assign sum = ((cin & ~((~b & (b | (~b & a))) | ((b | (~b & a)) & ~a))) | ((~cin & (b | (~b & a))) & (~b & a))) | ((~cin & (b | (~b & a))) & ~a);
  assign g = b & a;
  assign p = b | (~b & a);
endmodule

