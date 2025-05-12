
module overflow(Cout,V,g,p,c31,Cin);

  output Cout,V;
  input  g,p,c31,Cin;

  assign Cout = ((p & (g | Cin)) | (g & Cin)) | g;
  assign V = ((c31 | ~c31) & Cout) ^ c31;
endmodule

