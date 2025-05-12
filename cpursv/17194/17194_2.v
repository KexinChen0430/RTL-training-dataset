
module add(a,b,c,g,p,s);

  input  a,b,c;
  output g,p,s;

  assign s = (((~c | ~((~a & (a | b)) | (a & ~b))) & ((~a & b) | (b & ~b))) ^ ((~c | ~((~a & (a | b)) | (a & ~b))) & ((((a | b) & ~b) | ~a) & a))) | (~((~a & (a | b)) | (a & ~b)) & c);
  assign g = a & b;
  assign p = a | b;
endmodule

