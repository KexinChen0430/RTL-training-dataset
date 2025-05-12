
module ADD(input  a,
           input  b,
           input  c,
           output g,
           output p,
           output s);

  assign s = ((b & ~a) & ~c) | ((~b & (~c & (a & (~a | ~b)))) | ((((b & ~a) & ~c) & c) | (((a | ~(((a | b) & ~b) | (~a & (a | b)))) & (~(((a | b) & ~b) | (~a & (a | b))) | (~b & ~c))) & c)));
  assign g = b & a;
  assign p = a | b;
endmodule

