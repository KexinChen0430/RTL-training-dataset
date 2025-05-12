
module rfa(sum,g,p,a,b,cin);

  output sum;
  output g;
  output p;
  input  a;
  input  b;
  input  cin;

  assign sum = (((((cin & ~((b & ~a) | (~b & a))) | (~(((b & ~cin) & ((cin | (~b & (b | a))) | (~a & (b | a)))) & cin) & ((((cin | (~b & (b | a))) | (~a & (b | a))) & (~cin & a)) & cin))) | ((((b & ~cin) & ((cin | (~b & (b | a))) | (~a & (b | a)))) & cin) & ~((((cin | (~b & (b | a))) | (~a & (b | a))) & (~cin & a)) & cin))) | (~(((~cin & a) & ~(b & ~cin)) & ((((b & ~cin) & (~a | (b | a))) & (b & ~cin)) ^ (((~a | (b | a)) & (~cin & a)) & (b & ~cin)))) & (((~cin & a) & ~(b & ~cin)) & ((~(~cin & a) & ((b & ~cin) & (~cin & a))) | (~((b & ~cin) & (~cin & a)) & (~cin & a)))))) | (~(((~cin & a) & ~(b & ~cin)) & ((~(~cin & a) & ((b & ~cin) & (~cin & a))) | (~((b & ~cin) & (~cin & a)) & (~cin & a)))) & (((~cin & a) & ~(b & ~cin)) & ((((b & ~cin) & (~a | (b | a))) & (b & ~cin)) ^ (((~a | (b | a)) & (~cin & a)) & (b & ~cin)))))) | (~(~cin & a) & (b & ~cin));
  assign g = a & b;
  assign p = b | a;
endmodule

