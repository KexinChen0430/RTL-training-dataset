
module rfa(sum,g,p,a,b,cin);

  output sum;
  output g;
  output p;
  input  a;
  input  b;
  input  cin;

  assign sum = (((b & ~a) | (cin & ~((b & ~a) | (a & (((a | b) & ~b) | ~a))))) & ((((~(a & ~cin) & b) & ~cin) & ((~((b & ~a) | (a & (((a | b) & ~b) | ~a))) | ~((b & ~a) | (a & (((a | b) & ~b) | ~a)))) | (((a | b) & ~b) | ~a))) | (((~((b & ~a) | (a & (((a | b) & ~b) | ~a))) | ~((b & ~a) | (a & (((a | b) & ~b) | ~a)))) | (((a | b) & ~b) | ~a)) & ((~((b & ~a) | (a & (((a | b) & ~b) | ~a))) | (a & ~cin)) & (~((b & ~a) | (a & (((a | b) & ~b) | ~a))) | ~(~cin & b)))))) | ((a & (((a | b) & ~b) | ~a)) & ~cin);
  assign g = b & a;
  assign p = a | b;
endmodule

