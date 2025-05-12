
module overflow(Cout,V,g,p,c31,Cin);

  output Cout,V;
  input  g,p,c31,Cin;

  assign Cout = ((((p & g) & Cin) | ((p | (g & (Cin | (p & g)))) & (Cin | p))) & Cin) | g;
  assign V = c31 ^ ((((c31 | (Cout ^ (c31 & Cout))) | ~c31) & Cout) & (~Cout | Cout));
endmodule

