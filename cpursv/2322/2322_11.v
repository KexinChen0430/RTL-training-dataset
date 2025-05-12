
module overflow(Cout,V,g,p,c31,Cin);

  output Cout,V;
  input  g,p,c31,Cin;

  assign Cout = g | ((((p & g) & Cin) | p) & Cin);
  assign V = Cout ^ c31;
endmodule

