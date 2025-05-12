
module rfa(sum,g,p,a,b,cin);

  output sum;
  output g;
  output p;
  input  a;
  input  b;
  input  cin;

  assign sum = (((~(a ^ b) & cin) | (~b & a)) | ((b & ~a) | cin)) & ((((~(~cin & b) & ~cin) | ~(a ^ b)) & (~(a ^ b) | a)) | ~cin);
  assign g = a & b;
  assign p = b | (~b & a);
endmodule

