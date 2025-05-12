
module overflow(Cout,V,g,p,c31,Cin);

  output Cout,V;
  input  g,p,c31,Cin;

  assign Cout = (Cin & p) | g;
  assign V = c31 ^ ((c31 | ~c31) & Cout);
endmodule

