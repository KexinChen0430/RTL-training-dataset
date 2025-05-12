
module ADD(input  a,
           input  b,
           input  c,
           output g,
           output p,
           output s);

  assign s = (((b & (((~b | b) & ~b) | ~a)) | (((~b & (a | (b & ~a))) & a) | c)) & ~c) | (~((b & ~a) | ((~b & (a | (b & ~a))) & a)) & c);
  assign g = a & b;
  assign p = a | (b & ~a);
endmodule

