
module ADD(input  a,
           input  b,
           input  c,
           output g,
           output p,
           output s);

  assign s = (((~b & (a | (b & ~a))) & (((a & (~b & (a | (b & ~a)))) & ~c) | ((~a & ~c) | ~((a & ((~b | ~b) | (~a & (a | (b & ~a))))) | (((~b | ~b) | (~a & (a | (b & ~a)))) & b))))) | ((((a & (~b & (a | (b & ~a)))) & ~c) | ((~a & ~c) | ~((a & ((~b | ~b) | (~a & (a | (b & ~a))))) | (((~b | ~b) | (~a & (a | (b & ~a)))) & b)))) & (b & ~a))) | (c & ~((a & ((~b | ~b) | (~a & (a | (b & ~a))))) | (((~b | ~b) | (~a & (a | (b & ~a)))) & b)));
  assign g = a & b;
  assign p = a | (b & ~a);
endmodule

