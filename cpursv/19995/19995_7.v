
module ADD(input  a,
           input  b,
           input  c,
           output g,
           output p,
           output s);

  assign s = (~(((b & (~a & (a | b))) | (~b & b)) ^ (a & (((b & (~a & (a | b))) | (~b & b)) | ~b))) & ((c | (b & (~a & (a | b)))) | (a & (((b & (~a & (a | b))) | (~b & b)) | ~b)))) | (((~c & a) & ((~(((b & (~a & (a | b))) | (~b & b)) ^ (a & (((b & (~a & (a | b))) | (~b & b)) | ~b))) | (~a & ~c)) | ~c)) ^ ((~c & b) & ((~(((b & (~a & (a | b))) | (~b & b)) ^ (a & (((b & (~a & (a | b))) | (~b & b)) | ~b))) | (~a & ~c)) | ~c)));
  assign g = a & b;
  assign p = a | b;
endmodule

