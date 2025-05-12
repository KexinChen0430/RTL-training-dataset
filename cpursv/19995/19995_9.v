
module ADD(input  a,
           input  b,
           input  c,
           output g,
           output p,
           output s);

  assign s = ((((~(((((~b & (b | a)) & a) | ~a) & b) ^ (((((~b & (b | a)) & a) | ~a) & a) & (a | ~a))) & c) | (~a & ((~b & (b | a)) & a))) | (((~b & (b | a)) & a) & ~b)) & (((~(((((~b & (b | a)) & a) | ~a) & b) ^ (((((~b & (b | a)) & a) | ~a) & a) & (a | ~a))) & c) | (~(((((~b & (b | a)) & a) | ~a) & b) ^ (((((~b & (b | a)) & a) | ~a) & a) & (a | ~a))) & c)) | ~c)) | ((~c & b) & ~a);
  assign g = b & a;
  assign p = b | a;
endmodule

