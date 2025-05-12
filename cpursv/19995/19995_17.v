
module ADD(input  a,
           input  b,
           input  c,
           output g,
           output p,
           output s);

  assign s = ((((((~a | (~b & a)) & a) | (~(((~a | (~b & a)) & a) | (b & (~a | (~b & a)))) & c)) | ((((b | a) & ~a) & b) | c)) & ~(((~a | (~b & a)) & a) | (b & (~a | (~b & a))))) | (~b & (a & ~c))) | (~c & (b & (~a | (~b & a))));
  assign g = b & a;
  assign p = b | a;
endmodule

