
module add(a,b,c,g,p,s);

  input  a,b,c;
  output g,p,s;

  assign s = ((~((~b | b) & ((b & ~c) & (~b | b))) & ((~b | b) & ((a & ~c) & (~b | b)))) | (((~b | b) & ((b & ~c) & (~b | b))) & ~((~b | b) & ((a & ~c) & (~b | b))))) | ((c & ~c) | (c & ~(((b & ~a) | (~b & b)) ^ (((~b | ~b) | ((b & ~a) | (~b & b))) & a))));
  assign g = a & b;
  assign p = (b & ~a) | a;
endmodule

