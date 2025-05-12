
module rfa(sum,g,p,a,b,cin);

  output sum;
  output g;
  output p;
  input  a;
  input  b;
  input  cin;

  assign sum = (~cin | ((~cin & ~a) | ~((b | (a & ~b)) & (~a | ~b)))) & ((cin | ((~a & b) | (b & ~b))) | (a & ~b));
  assign g = b & a;
  assign p = b | (a & ~b);
endmodule

