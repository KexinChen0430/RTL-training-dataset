
module overflow(Cout,V,g,p,c31,Cin);

  output Cout,V;
  input  g,p,c31,Cin;

  assign Cout = (Cin & p) | g;
  assign V = ((Cout | ~Cout) & ((c31 | ~c31) & Cout)) ^ c31;
endmodule

