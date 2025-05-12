
module add(a,b,c,g,p,s);

  input  a,b,c;
  output g,p,s;

  assign s = ((a & ~(~c & b)) & ~c) | ((((~c & ~(~c & a)) | ~((~(((a & (~b & ((b & ~a) | a))) & b) | (b & ~a)) & (((~a | ~a) | ~b) & a)) | (~(((~a | ~a) | ~b) & a) & (((a & (~b & ((b & ~a) | a))) & b) | (b & ~a))))) & (~((~(((a & (~b & ((b & ~a) | a))) & b) | (b & ~a)) & (((~a | ~a) | ~b) & a)) | (~(((~a | ~a) | ~b) & a) & (((a & (~b & ((b & ~a) | a))) & b) | (b & ~a)))) | b)) & (((((~a | ~a) | ~b) & a) | (c & ~((~(((a & (~b & ((b & ~a) | a))) & b) | (b & ~a)) & (((~a | ~a) | ~b) & a)) | (~(((~a | ~a) | ~b) & a) & (((a & (~b & ((b & ~a) | a))) & b) | (b & ~a)))))) | (c | (b & ~a))));
  assign g = b & a;
  assign p = (b & ~a) | a;
endmodule

