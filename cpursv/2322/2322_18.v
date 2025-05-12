
module overflow(Cout,V,g,p,c31,Cin);

  output Cout,V;
  input  g,p,c31,Cin;

  assign Cout = g | (Cin & p);
  assign V = ((((Cout & ~(c31 & Cout)) | ((c31 & Cout) & ~Cout)) & c31) | (~Cout & c31)) ^ ((Cout & ~(c31 & Cout)) | ((c31 & Cout) & ~Cout));
endmodule

