
module add(a,b,c,g,p,s);

  input  a,b,c;
  output g,p,s;

  assign s = (((~a & b) | (~a & (~b & a))) | (~b & (~b & a))) ^ c;
  assign g = a & b;
  assign p = a | b;
endmodule

