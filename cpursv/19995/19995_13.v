
module ADD(input  a,
           input  b,
           input  c,
           output g,
           output p,
           output s);

  assign s = ((b & (~b | (~a & (b | a)))) & ~c) | ((c & ~((b & (~a & (b | a))) | ((b | a) & ~b))) | (~c & (a & ((b | a) & ~b))));
  assign g = b & a;
  assign p = b | a;
endmodule

