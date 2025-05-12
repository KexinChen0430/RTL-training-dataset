
module ADD(input  a,
           input  b,
           input  c,
           output g,
           output p,
           output s);

  assign s = ((((~(((~a | (~b & (b | a))) & a) | (b & (~a | (~b & (b | a))))) & c) | ((c & ((a & ~c) & (c | (((~a | (~b & (b | a))) & a) | (b & (~a | (~b & (b | a)))))))) & ~(c & ((~c & b) & (c | (((~a | (~b & (b | a))) & a) | (b & (~a | (~b & (b | a)))))))))) | ((c & ((~c & b) & (c | (((~a | (~b & (b | a))) & a) | (b & (~a | (~b & (b | a)))))))) & ~(c & ((a & ~c) & (c | (((~a | (~b & (b | a))) & a) | (b & (~a | (~b & (b | a)))))))))) | ((((a & ~c) & ((~a | ~a) | a)) & ((~a | (~b & (b | a))) | ~(((~a | (~b & (b | a))) & a) | (b & (~a | (~b & (b | a))))))) & ~(((~a | (~b & (b | a))) | ~(((~a | (~b & (b | a))) & a) | (b & (~a | (~b & (b | a)))))) & ((~c & b) & ((~a | ~a) | a))))) | ((((~a | (~b & (b | a))) | ~(((~a | (~b & (b | a))) & a) | (b & (~a | (~b & (b | a)))))) & ((~c & b) & ((~a | ~a) | a))) & ~(((a & ~c) & ((~a | ~a) | a)) & ((~a | (~b & (b | a))) | ~(((~a | (~b & (b | a))) & a) | (b & (~a | (~b & (b | a))))))));
  assign g = a & b;
  assign p = b | a;
endmodule

