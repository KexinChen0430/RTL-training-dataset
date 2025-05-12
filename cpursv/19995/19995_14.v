
module ADD(input  a,
           input  b,
           input  c,
           output g,
           output p,
           output s);

  assign s = (((~c & b) | (~((a | b) & (~a | (a & ~b))) & c)) & (~a | (~((a | b) & (~a | (a & ~b))) & c))) | (~c & (a & (~a | (a & ~b))));
  assign g = a & b;
  assign p = a | b;
endmodule

