
module rfa(sum,g,p,a,b,cin);

  output sum;
  output g;
  output p;
  input  a;
  input  b;
  input  cin;

  assign sum = (((((~(~cin & a) | ~((~b & a) | ((b | (~b & a)) & ~a))) & ((~cin & b) | ~((~b & a) | ((b | (~b & a)) & ~a)))) & cin) | (cin & ((~cin & ~(~cin & b)) & a))) | ((((~cin & b) | (((~cin & a) & ((~cin & a) & ~b)) & ~(((~cin & a) & ~b) & (~cin & b)))) | ((((~cin & a) & ~b) & (~cin & b)) & ~((~cin & a) & ((~cin & a) & ~b)))) & ~b)) | ((((~cin & b) | (((~cin & a) & ((~cin & a) & ~b)) & ~(((~cin & a) & ~b) & (~cin & b)))) | ((((~cin & a) & ~b) & (~cin & b)) & ~((~cin & a) & ((~cin & a) & ~b)))) & (~a & b));
  assign g = b & a;
  assign p = b | (~b & a);
endmodule

