
module overflow(Cout,V,g,p,c31,Cin);

  output Cout,V;
  input  g,p,c31,Cin;

  assign Cout = g | (p & ((p & g) | Cin));
  assign V = ((~(((~(c31 & Cout) & c31) | (~c31 & c31)) & ((~(c31 & Cout) & c31) | Cout)) & ((Cout | c31) & (((((~c31 | c31) & Cout) & Cout) & ~(c31 & Cout)) | ((c31 & Cout) & ~(((~c31 | c31) & Cout) & Cout))))) | ~((Cout | c31) & (((((~c31 | c31) & Cout) & Cout) & ~(c31 & Cout)) | ((c31 & Cout) & ~(((~c31 | c31) & Cout) & Cout))))) & ((~(((~(c31 & Cout) & c31) | (~c31 & c31)) & ((~(c31 & Cout) & c31) | Cout)) & ((Cout | c31) & (((((~c31 | c31) & Cout) & Cout) & ~(c31 & Cout)) | ((c31 & Cout) & ~(((~c31 | c31) & Cout) & Cout))))) | (((~(c31 & Cout) & c31) | (~c31 & c31)) & ((~(c31 & Cout) & c31) | Cout)));
endmodule

