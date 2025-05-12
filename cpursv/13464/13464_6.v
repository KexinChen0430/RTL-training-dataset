
module rfa(sum,g,p,a,b,cin);

  output sum;
  output g;
  output p;
  input  a;
  input  b;
  input  cin;

  assign sum = (((~((~a | (~b & a)) & (b | a)) | (~(((~b & a) & ~cin) & (((~b | ~((~a | (~b & a)) & (b | a))) | ~a) & (~cin & b))) & (((a & ~cin) & ((~b | ~((~a | (~b & a)) & (b | a))) | ~a)) & ((~b & a) & ~cin)))) | (~(((a & ~cin) & ((~b | ~((~a | (~b & a)) & (b | a))) | ~a)) & ((~b & a) & ~cin)) & (((~b & a) & ~cin) & (((~b | ~((~a | (~b & a)) & (b | a))) | ~a) & (~cin & b))))) | ((b & (((((~((~a | (~b & a)) & (b | a)) & cin) | (a & (~a | (~b & a)))) & ((~((~a | (~b & a)) & (b | a)) & cin) | ~b)) | (~a & (b | a))) & ~cin)) ^ ((((((~((~a | (~b & a)) & (b | a)) & cin) | (a & (~a | (~b & a)))) & ((~((~a | (~b & a)) & (b | a)) & cin) | ~b)) | (~a & (b | a))) & ~cin) & a))) & (((~((~a | (~b & a)) & (b | a)) & cin) | (~(~cin & b) & a)) | (~(a & ~cin) & (~cin & b)));
  assign g = b & a;
  assign p = b | a;
endmodule

