
module rfa(sum,g,p,a,b,cin);

  output sum;
  output g;
  output p;
  input  a;
  input  b;
  input  cin;

  assign sum = ((~cin & ((a | b) & ~a)) | ((a & ~cin) & ~b)) | (~(((a | b) & ~b) | ((a | b) & ~a)) & cin);
  assign g = b & a;
  assign p = a | b;
endmodule

