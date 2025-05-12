
module rfa(sum,g,p,a,b,cin);

  output sum;
  output g;
  output p;
  input  a;
  input  b;
  input  cin;

  assign sum = (((((cin & ~((a & ~b) | (~a & (b | a)))) | (~a & b)) | (a & ~b)) & ~((a & ~b) | (~a & (b | a)))) | (~cin & ((~a | ((b | a) & ~b)) & a))) | (~cin & (~a & b));
  assign g = b & a;
  assign p = b | a;
endmodule

