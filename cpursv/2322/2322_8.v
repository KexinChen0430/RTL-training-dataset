
module overflow(Cout,V,g,p,c31,Cin);

  output Cout,V;
  input  g,p,c31,Cin;

  assign Cout = (p & Cin) | g;
  assign V = ((Cout | ~Cout) & (Cout & (c31 | ~c31))) ^ c31;
endmodule

