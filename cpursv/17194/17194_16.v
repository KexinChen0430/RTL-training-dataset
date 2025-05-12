
module add(a,b,c,g,p,s);

  input  a,b,c;
  output g,p,s;

  assign s = (((((b & ~a) | (~b & b)) & ~c) | c) | (a & (~b & ~c))) & ((((b & ~a) | (~b & b)) & ~c) | ((~((~a & (b | a)) | ((b | a) & ~b)) | (((~c & b) & (a & (~b & ~c))) & ~((a & (~b & ~c)) & (a & ~c)))) | (((a & (~b & ~c)) & (a & ~c)) & ~((~c & b) & (a & (~b & ~c))))));
  assign g = a & b;
  assign p = b | a;
endmodule

