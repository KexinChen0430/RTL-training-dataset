
module ADD(input  a,
           input  b,
           input  c,
           output g,
           output p,
           output s);

  assign s = ((((~a & b) | (b & (~b & a))) | ((~b | (c & ~(a ^ b))) & (a | (c & ~(a ^ b))))) & ~(a ^ b)) | ((((~a & b) | (b & (~b & a))) | ((~b | (c & ~(a ^ b))) & (a | (c & ~(a ^ b))))) & ~c);
  assign g = a & b;
  assign p = ((~a & b) | b) | a;
endmodule

