
module rfa(sum,g,p,a,b,cin);

  output sum;
  output g;
  output p;
  input  a;
  input  b;
  input  cin;

  assign sum = ((~((~a & b) | (a & ~b)) & cin) | ((((~((~a & b) | (a & ~b)) | b) | (~b & ((b | ((a & ~b) & ~a)) | (a & ~b)))) & (((~((~a & b) | (a & ~b)) & cin) | ((~a & b) | (a & ~b))) & ((~((~a & b) | (a & ~b)) | ~cin) & (b & ~cin)))) & ~((((~((~a & b) | (a & ~b)) | ~cin) & (~cin & a)) & ((~((~a & b) | (a & ~b)) & cin) | ((~a & b) | (a & ~b)))) & ((~((~a & b) | (a & ~b)) | b) | (~b & ((b | ((a & ~b) & ~a)) | (a & ~b))))))) | (((((~((~a & b) | (a & ~b)) | ~cin) & (~cin & a)) & ((~((~a & b) | (a & ~b)) & cin) | ((~a & b) | (a & ~b)))) & ((~((~a & b) | (a & ~b)) | b) | (~b & ((b | ((a & ~b) & ~a)) | (a & ~b))))) & ~(((~((~a & b) | (a & ~b)) | b) | (~b & ((b | ((a & ~b) & ~a)) | (a & ~b)))) & (((~((~a & b) | (a & ~b)) & cin) | ((~a & b) | (a & ~b))) & ((~((~a & b) | (a & ~b)) | ~cin) & (b & ~cin)))));
  assign g = a & b;
  assign p = (b | ((a & ~b) & ~a)) | (a & ~b);
endmodule

