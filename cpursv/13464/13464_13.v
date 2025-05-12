
module rfa(sum,g,p,a,b,cin);

  output sum;
  output g;
  output p;
  input  a;
  input  b;
  input  cin;

  assign sum = (((~(((b & ~a) | ((a & ~b) & b)) ^ ((~b | ~a) & a)) & cin) | (((((((~b | ~a) & (b & ~cin)) | ((~b & (~cin & ((~b | ~a) & a))) | ~(((b & ~a) | ((a & ~b) & b)) ^ ((~b | ~a) & a)))) & (b & ~cin)) & ((~b | a) | (b & ~a))) & (~b & (~cin & ((~b | ~a) & a)))) & ~((~b & (~cin & ((~b | ~a) & a))) & (((~b | a) | (b & ~a)) & ((((~b | ~a) & (b & ~cin)) | ((~b & (~cin & ((~b | ~a) & a))) | ~(((b & ~a) | ((a & ~b) & b)) ^ ((~b | ~a) & a)))) & (~cin & a)))))) | (~((((((~b | ~a) & (b & ~cin)) | ((~b & (~cin & ((~b | ~a) & a))) | ~(((b & ~a) | ((a & ~b) & b)) ^ ((~b | ~a) & a)))) & (b & ~cin)) & ((~b | a) | (b & ~a))) & (~b & (~cin & ((~b | ~a) & a)))) & ((~b & (~cin & ((~b | ~a) & a))) & (((~b | a) | (b & ~a)) & ((((~b | ~a) & (b & ~cin)) | ((~b & (~cin & ((~b | ~a) & a))) | ~(((b & ~a) | ((a & ~b) & b)) ^ ((~b | ~a) & a)))) & (~cin & a)))))) | ((((~b | ~a) & (b & ~cin)) | ((~b & (~cin & ((~b | ~a) & a))) | ~(((b & ~a) | ((a & ~b) & b)) ^ ((~b | ~a) & a)))) & (b & ~a));
  assign g = a & b;
  assign p = b | a;
endmodule

