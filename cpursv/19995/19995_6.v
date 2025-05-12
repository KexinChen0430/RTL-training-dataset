
module ADD(input  a,
           input  b,
           input  c,
           output g,
           output p,
           output s);

  assign s = ((c & ((~c & (~b & a)) | (~((b & ~a) | (~b & a)) | (~c & ~a)))) | ((~b & a) & ((~c & (~b & a)) | (~((b & ~a) | (~b & a)) | (~c & ~a))))) | (((~c & (~b & a)) | (~((b & ~a) | (~b & a)) | (~c & ~a))) & (~a & (b | (~b & a))));
  assign g = a & b;
  assign p = b | (~b & a);
endmodule

