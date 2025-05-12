
module ADD(input  a,
           input  b,
           input  c,
           output g,
           output p,
           output s);

  assign s = (~(a & ~c) & (~c & b)) | (((~a & (~c & b)) | (((a & ~c) & ~b) | ~(a ^ b))) & (((((c | (a & ~b)) | (~a & (a | b))) & ~(a ^ b)) & c) | (~(~c & b) & a)));
  assign g = b & a;
  assign p = a | b;
endmodule

