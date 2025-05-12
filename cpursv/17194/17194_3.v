
module add(a,b,c,g,p,s);

  input  a,b,c;
  output g,p,s;

  assign s = ((((~c & a) ^ (~c & b)) | (~(((~b | ~a) & a) ^ ((~b | ~a) & b)) | (~a & (~c & b)))) & ((a | (c & ~(((~b | ~a) & a) ^ ((~b | ~a) & b)))) & (~b | (c & ~(((~b | ~a) & a) ^ ((~b | ~a) & b)))))) | (((b | a) & ~a) & ~c);
  assign g = a & b;
  assign p = b | a;
endmodule

