
module ADD(input  a,
           input  b,
           input  c,
           output g,
           output p,
           output s);

  assign s = ((~((~a | ~b) & (a | b)) | (~c & ((~a & (a | b)) | (c | (a & ~b))))) & ((~a | ~b) & (a | b))) | ((((c & (((a & ~c) & (~((~a | ~b) & (a | b)) | (~c & ((~a & (a | b)) | (c | (a & ~b)))))) & (~a | a))) & ~(c & ((~a | a) & ((~((~a | ~b) & (a | b)) | (~c & ((~a & (a | b)) | (c | (a & ~b))))) & (~c & b))))) | ((c & ((~a | a) & ((~((~a | ~b) & (a | b)) | (~c & ((~a & (a | b)) | (c | (a & ~b))))) & (~c & b)))) & ~(c & (((a & ~c) & (~((~a | ~b) & (a | b)) | (~c & ((~a & (a | b)) | (c | (a & ~b)))))) & (~a | a))))) | (c & ~((~a | ~b) & (a | b))));
  assign g = a & b;
  assign p = a | b;
endmodule

