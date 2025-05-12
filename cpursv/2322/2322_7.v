
module overflow(Cout,V,g,p,c31,Cin);

  output Cout,V;
  input  g,p,c31,Cin;

  assign Cout = (p | g) & (Cin | g);
  assign V = Cout ^ c31;
endmodule

