
module add(a,b,c,g,p,s);

  input  a,b,c;
  output g,p,s;

  assign s = ((((~((((~b | ~b) | ((b | a) & ~a)) & a) | (b & ((~b | ~b) | ((b | a) & ~a)))) | ((b & ~c) & ~a)) | ~c) & c) | ((((~((((~b | ~b) | ((b | a) & ~a)) & a) | (b & ((~b | ~b) | ((b | a) & ~a)))) | ((b & ~c) & ~a)) | ~c) & a) & ~(b & ((~((((~b | ~b) | ((b | a) & ~a)) & a) | (b & ((~b | ~b) | ((b | a) & ~a)))) | ((b & ~c) & ~a)) | ~c)))) | ((b & ((~((((~b | ~b) | ((b | a) & ~a)) & a) | (b & ((~b | ~b) | ((b | a) & ~a)))) | ((b & ~c) & ~a)) | ~c)) & ~(((~((((~b | ~b) | ((b | a) & ~a)) & a) | (b & ((~b | ~b) | ((b | a) & ~a)))) | ((b & ~c) & ~a)) | ~c) & a));
  assign g = a & b;
  assign p = b | a;
endmodule

