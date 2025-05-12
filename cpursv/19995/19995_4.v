
module ADD(input  a,
           input  b,
           input  c,
           output g,
           output p,
           output s);

  assign s = ((((c & ((~(b ^ a) | (~(((a & ~c) & ~(b & ~c)) & (((b & ~c) & (~c | ~(b ^ a))) & (~c | ~(b ^ a)))) & (((a & ~c) & ~(b & ~c)) & ((~c | ~(b ^ a)) & ((a & ~c) & (~c | ~(b ^ a))))))) | ((((a & ~c) & ~(b & ~c)) & (((b & ~c) & (~c | ~(b ^ a))) & (~c | ~(b ^ a)))) & ~(((a & ~c) & ~(b & ~c)) & ((~c | ~(b ^ a)) & ((a & ~c) & (~c | ~(b ^ a)))))))) | ((~c & ((~c | ~(b ^ a)) & (~(a & ~c) & b))) & c)) | (~(((a & ~c) & (~c | ~(b ^ a))) & ((a & ~c) & ~(b & ~c))) & (((a & ~c) & ~(b & ~c)) & ((b & ~c) & (~c | ~(b ^ a)))))) | (~(((a & ~c) & ~(b & ~c)) & ((b & ~c) & (~c | ~(b ^ a)))) & (((a & ~c) & (~c | ~(b ^ a))) & ((a & ~c) & ~(b & ~c))))) | (~c & ((~c | ~(b ^ a)) & (~(a & ~c) & b)));
  assign g = b & a;
  assign p = (b ^ a) | b;
endmodule

