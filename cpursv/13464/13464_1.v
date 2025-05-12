
module rfa(sum,g,p,a,b,cin);

  output sum;
  output g;
  output p;
  input  a;
  input  b;
  input  cin;

  assign sum = ((((((~a & b) | cin) | a) & (((~a & b) | cin) | ((~b & ((a | (~a & b)) | ~b)) | ~a))) & ((~((((~b & ((a | (~a & b)) | ~b)) | ~a) & a) ^ (b & ((~b & ((a | (~a & b)) | ~b)) | ~a))) | ((((a & ~cin) & ~b) & (((a | (~a & b)) | ~b) & (a & ~cin))) & ~(((a & ~cin) & ~b) & ((b & ~cin) & ((a | (~a & b)) | ~b))))) | ((((a & ~cin) & ~b) & ((b & ~cin) & ((a | (~a & b)) | ~b))) & ~(((a & ~cin) & ~b) & (((a | (~a & b)) | ~b) & (a & ~cin)))))) | ((((b & ~cin) & ~a) & (b & ~cin)) & ~(((b & ~cin) & ~a) & (a & ~cin)))) | ((((b & ~cin) & ~a) & (a & ~cin)) & ~(((b & ~cin) & ~a) & (b & ~cin)));
  assign g = a & b;
  assign p = a | (~a & b);
endmodule

