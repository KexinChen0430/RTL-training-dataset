
module add(a,b,c,g,p,s);

  input  a,b,c;
  output g,p,s;

  assign s = c ^ ((~b & (b | a)) | (b & ~a));
  assign g = a & b;
  assign p = b | a;
endmodule

