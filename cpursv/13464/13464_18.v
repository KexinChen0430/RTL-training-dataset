
module rfa(sum,g,p,a,b,cin);

  output sum;
  output g;
  output p;
  input  a;
  input  b;
  input  cin;

  assign sum = ((a & ~cin) | (((cin & ~((~b | (((b & ~a) | a) & ~a)) & ((b & ~a) | a))) | (b & ~a)) & (~cin | ~((~b | (((b & ~a) | a) & ~a)) & ((b & ~a) | a))))) & (((((b & ~a) | a) & ~a) | ((a & ~b) | cin)) | ~b);
  assign g = a & b;
  assign p = (b & ~a) | a;
endmodule

