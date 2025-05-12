
module rfa(sum,g,p,a,b,cin);

  output sum;
  output g;
  output p;
  input  a;
  input  b;
  input  cin;

  assign sum = (((~a | (~b & a)) & b) & ~cin) | (((~cin & a) & ~b) | (cin & ~(((b & ~a) | a) & (~a | (~b & a)))));
  assign g = b & a;
  assign p = (b & ~a) | a;
endmodule

