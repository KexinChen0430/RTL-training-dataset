
module add(a,b,c,g,p,s);

  input  a,b,c;
  output g,p,s;

  assign s = ((~((a & (~a | (~b & a))) | (~a & b)) & c) | (c & ~c)) | ((((b & ~b) | (~a & b)) & ((~((a & (~a | (~b & a))) | (~a & b)) | (~c & (~a & b))) | ((~b & ~c) & a))) | ((~b & a) & ((~((a & (~a | (~b & a))) | (~a & b)) | (~c & (~a & b))) | ((~b & ~c) & a))));
  assign g = a & b;
  assign p = b | a;
endmodule

