
module rfa(sum,g,p,a,b,cin);

  output sum;
  output g;
  output p;
  input  a;
  input  b;
  input  cin;

  assign sum = ((((~cin & (a & ~b)) | ~((~a & ((a & ~b) | b)) | (((a & ~b) | b) & ~b))) | (~cin & ~a)) & (((((((~cin & (a & ~b)) | ~((~a & ((a & ~b) | b)) | (((a & ~b) | b) & ~b))) | (~cin & ~a)) & cin) & ~((~a & ((a & ~b) | b)) | (((a & ~b) | b) & ~b))) | ~a) & ((((((~cin & (a & ~b)) | ~((~a & ((a & ~b) | b)) | (((a & ~b) | b) & ~b))) | (~cin & ~a)) & cin) & ~((~a & ((a & ~b) | b)) | (((a & ~b) | b) & ~b))) | b))) | ((((((a & ~cin) & (((a & ~b) | cin) | (~a & b))) & ((((~cin & (a & ~b)) | ~((~a & ((a & ~b) | b)) | (((a & ~b) | b) & ~b))) | (~cin & ~a)) & ((~a & b) | ~((~a & ((a & ~b) | b)) | (((a & ~b) | b) & ~b))))) ^ (((((~cin & (a & ~b)) | ~((~a & ((a & ~b) | b)) | (((a & ~b) | b) & ~b))) | (~cin & ~a)) & ((~a & b) | ~((~a & ((a & ~b) | b)) | (((a & ~b) | b) & ~b)))) & ((((a & ~b) | cin) | (~a & b)) & (b & ~cin)))) | (~cin & (a & ~b))) & ((~cin & (a & ~b)) | ~((~a & ((a & ~b) | b)) | (((a & ~b) | b) & ~b))));
  assign g = b & a;
  assign p = (a & ~b) | b;
endmodule

