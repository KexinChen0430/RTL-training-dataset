
module ADD(input  a,
           input  b,
           input  c,
           output g,
           output p,
           output s);

  assign s = (((((~((b | a) & (((b | a) & ~b) | ~a)) & c) | (~a & b)) | ((((b | a) & ~b) | ~a) & a)) & ~((b | a) & (((b | a) & ~b) | ~a))) | ((b & ~c) & (~(~c & a) & (~((b | a) & (((b | a) & ~b) | ~a)) | ~c)))) | ((~(b & ~c) & ~c) & a);
  assign g = a & b;
  assign p = b | a;
endmodule

