
module add(a,b,c,g,p,s);

  input  a,b,c;
  output g,p,s;

  assign s = ((b | (c & ~(((~a & b) | (~b & b)) | (a & (~b | ~a))))) | (~b & ((a & ~b) | b))) & (((c & ~(((~a & b) | (~b & b)) | (a & (~b | ~a)))) | (~c & ~a)) | (~c & ~b));
  assign g = b & a;
  assign p = (a & ~b) | b;
endmodule

