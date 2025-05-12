
module add(a,b,c,g,p,s);

  input  a,b,c;
  output g,p,s;

  assign s = ((b & ~a) | (((b & ~a) | ~b) & a)) ^ c;
  assign g = a & b;
  assign p = ((b & ~a) | (((b & ~a) | ~b) & a)) | b;
endmodule

