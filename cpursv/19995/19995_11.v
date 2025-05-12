
module ADD(input  a,
           input  b,
           input  c,
           output g,
           output p,
           output s);

  assign s = (~c & (a & ~b)) | ((((~a & b) | ((a & ~b) & b)) & ~c) | (c & ~(b ^ a)));
  assign g = a & b;
  assign p = b | (a & ~b);
endmodule

