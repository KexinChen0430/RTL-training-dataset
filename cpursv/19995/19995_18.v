
module ADD(input  a,
           input  b,
           input  c,
           output g,
           output p,
           output s);

  assign s = (((((~((((b & ~a) | ~a) | (((~b | (~b & a)) | b) & ~b)) & (b | a)) | ((b & ~a) | (b & ~b))) | ~b) & (c | (~b & a))) & (((~a & ~c) | ~((((b & ~a) | ~a) | (((~b | (~b & a)) | b) & ~b)) & (b | a))) | (a & (~c & ~b)))) | (~(((((((b & ~a) | ~a) | (((~b | (~b & a)) | b) & ~b)) & a) | ((b & ~a) | (c & ~((((b & ~a) | ~a) | (((~b | (~b & a)) | b) & ~b)) & (b | a))))) & (~c & a)) & (~a & (~c & b))) & ((~a & (~c & b)) & ((~c & b) & (((((b & ~a) | ~a) | (((~b | (~b & a)) | b) & ~b)) & a) | ((b & ~a) | (c & ~((((b & ~a) | ~a) | (((~b | (~b & a)) | b) & ~b)) & (b | a))))))))) | (~((~a & (~c & b)) & ((~c & b) & (((((b & ~a) | ~a) | (((~b | (~b & a)) | b) & ~b)) & a) | ((b & ~a) | (c & ~((((b & ~a) | ~a) | (((~b | (~b & a)) | b) & ~b)) & (b | a))))))) & (((((((b & ~a) | ~a) | (((~b | (~b & a)) | b) & ~b)) & a) | ((b & ~a) | (c & ~((((b & ~a) | ~a) | (((~b | (~b & a)) | b) & ~b)) & (b | a))))) & (~c & a)) & (~a & (~c & b))));
  assign g = b & a;
  assign p = b | a;
endmodule

