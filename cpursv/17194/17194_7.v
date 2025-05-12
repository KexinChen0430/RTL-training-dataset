
module add(a,b,c,g,p,s);

  input  a,b,c;
  output g,p,s;

  assign s = ((c & ~(b ^ a)) | ((b & ~c) & ~a)) | ((a & ((a & ~b) | ~a)) & ~c);
  assign g = b & a;
  assign p = b | (a & ~b);
endmodule

