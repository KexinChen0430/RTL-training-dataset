
module overflow(Cout,V,g,p,c31,Cin);

  output Cout,V;
  input  g,p,c31,Cin;

  assign Cout = (g | p) & (((g & p) & Cin) | (g | Cin));
  assign V = (~Cout & c31) | (((~Cout & Cout) | ~c31) & ((~Cout & Cout) | Cout));
endmodule

