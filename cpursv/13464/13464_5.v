
module rfa(sum,g,p,a,b,cin);

  output sum;
  output g;
  output p;
  input  a;
  input  b;
  input  cin;

  assign sum = ((((((~(((a & ~b) | b) & ((~a | ((a & ~b) & ~a)) | (a & ~b))) | (~a & ~cin)) & (b | ~(((a & ~b) | b) & ((~a | ((a & ~b) & ~a)) | (a & ~b))))) | (((((a & ~b) | b) & ((~a | ((a & ~b) & ~a)) | (a & ~b))) | cin) & ~cin)) & cin) | (((~b & (a & ~cin)) & (((((~(((a & ~b) | b) & ((~a | ((a & ~b) & ~a)) | (a & ~b))) | (~a & ~cin)) & (b | ~(((a & ~b) | b) & ((~a | ((a & ~b) & ~a)) | (a & ~b))))) | (((((a & ~b) | b) & ((~a | ((a & ~b) & ~a)) | (a & ~b))) | cin) & ~cin)) & (a & ~cin)) & ((((a & ~b) | b) & ((~a | ((a & ~b) & ~a)) | (a & ~b))) | cin))) & ~((((((a & ~b) | b) & ((~a | ((a & ~b) & ~a)) | (a & ~b))) | cin) & ((((~(((a & ~b) | b) & ((~a | ((a & ~b) & ~a)) | (a & ~b))) | (~a & ~cin)) & (b | ~(((a & ~b) | b) & ((~a | ((a & ~b) & ~a)) | (a & ~b))))) | (((((a & ~b) | b) & ((~a | ((a & ~b) & ~a)) | (a & ~b))) | cin) & ~cin)) & (~cin & b))) & (~b & (a & ~cin))))) | (~((~b & (a & ~cin)) & (((((~(((a & ~b) | b) & ((~a | ((a & ~b) & ~a)) | (a & ~b))) | (~a & ~cin)) & (b | ~(((a & ~b) | b) & ((~a | ((a & ~b) & ~a)) | (a & ~b))))) | (((((a & ~b) | b) & ((~a | ((a & ~b) & ~a)) | (a & ~b))) | cin) & ~cin)) & (a & ~cin)) & ((((a & ~b) | b) & ((~a | ((a & ~b) & ~a)) | (a & ~b))) | cin))) & ((((((a & ~b) | b) & ((~a | ((a & ~b) & ~a)) | (a & ~b))) | cin) & ((((~(((a & ~b) | b) & ((~a | ((a & ~b) & ~a)) | (a & ~b))) | (~a & ~cin)) & (b | ~(((a & ~b) | b) & ((~a | ((a & ~b) & ~a)) | (a & ~b))))) | (((((a & ~b) | b) & ((~a | ((a & ~b) & ~a)) | (a & ~b))) | cin) & ~cin)) & (~cin & b))) & (~b & (a & ~cin))))) | (((~a & b) | (b & ~b)) & ~cin);
  assign g = a & b;
  assign p = (a & ~b) | b;
endmodule

