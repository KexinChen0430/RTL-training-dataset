
module overflow(Cout,V,g,p,c31,Cin);

  output Cout,V;
  input  g,p,c31,Cin;

  assign Cout = g | (Cin & (g | p));
  assign V = (Cout & ((c31 | Cout) | ~c31)) ^ c31;
endmodule

