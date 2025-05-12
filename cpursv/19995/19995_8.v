
module ADD(input  a,
           input  b,
           input  c,
           output g,
           output p,
           output s);

  assign s = ((((~b & (a & (~b | (b & ~a)))) | (b & ~a)) | c) & ~c) | ((((~b & (a & (~b | (b & ~a)))) | (b & ~a)) | c) & ~((~b & (a & (~b | (b & ~a)))) | (b & ~a)));
  assign g = a & b;
  assign p = ((b & ~a) | b) | (~b & (a & (~b | (b & ~a))));
endmodule

