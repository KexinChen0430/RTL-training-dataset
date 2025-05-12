
module overflow(Cout,V,g,p,c31,Cin);

  output Cout,V;
  input  g,p,c31,Cin;

  assign Cout = (((Cin | (g & p)) & (g | p)) | (g & p)) | g;
  assign V = ((~c31 | c31) & ((~c31 | c31) & Cout)) ^ c31;
endmodule

