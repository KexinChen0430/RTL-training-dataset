
module add(a,b,c,g,p,s);

  input  a,b,c;
  output g,p,s;

  assign s = (((~((~b & a) | (b & ~a)) | (((~(~c & b) & (~c & a)) & (((~b | ~a) | b) & (~c & b))) & ~(((~c & a) & ((~b | ~a) | b)) & (~(~c & b) & (~c & a))))) | ((((~c & a) & ((~b | ~a) | b)) & (~(~c & b) & (~c & a))) & ~((~(~c & b) & (~c & a)) & (((~b | ~a) | b) & (~c & b))))) & (((~b & a) | (b & ~a)) | (~((~b & a) | (b & ~a)) & c))) | ((((~((~b & a) | (b & ~a)) | (((~c & a) & ((~b | ~a) | b)) & ~(((~b | ~a) | b) & (~c & b)))) | ((((~b | ~a) | b) & (~c & b)) & ~((~c & a) & ((~b | ~a) | b)))) & (~c & b)) & ~(~c & a));
  assign g = a & b;
  assign p = a | (b & ~a);
endmodule

