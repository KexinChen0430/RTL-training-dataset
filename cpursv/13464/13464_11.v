
module rfa(sum,g,p,a,b,cin);

  output sum;
  output g;
  output p;
  input  a;
  input  b;
  input  cin;

  assign sum = (~((~a & b) | ((~b | ~a) & a)) & cin) | (((b & (~b | ~a)) & (((~((~a & b) | ((~b | ~a) & a)) | (~b & (((~b | ~a) & a) & ~cin))) | ((((~((~a & b) | ((~b | ~a) & a)) | ~b) | ~a) & ((b | ~b) & (~cin & b))) & ~(((~((~a & b) | ((~b | ~a) & a)) | ~b) | ~a) & ((a & ~cin) & (b | ~b))))) | (~(((~((~a & b) | ((~b | ~a) & a)) | ~b) | ~a) & ((b | ~b) & (~cin & b))) & (((~((~a & b) | ((~b | ~a) & a)) | ~b) | ~a) & ((a & ~cin) & (b | ~b)))))) | ((~b & a) & (((~((~a & b) | ((~b | ~a) & a)) | (~b & (((~b | ~a) & a) & ~cin))) | ((((~((~a & b) | ((~b | ~a) & a)) | ~b) | ~a) & ((b | ~b) & (~cin & b))) & ~(((~((~a & b) | ((~b | ~a) & a)) | ~b) | ~a) & ((a & ~cin) & (b | ~b))))) | (~(((~((~a & b) | ((~b | ~a) & a)) | ~b) | ~a) & ((b | ~b) & (~cin & b))) & (((~((~a & b) | ((~b | ~a) & a)) | ~b) | ~a) & ((a & ~cin) & (b | ~b)))))));
  assign g = b & a;
  assign p = (b | (~a & (~b & a))) | ((~b & a) & ~b);
endmodule

