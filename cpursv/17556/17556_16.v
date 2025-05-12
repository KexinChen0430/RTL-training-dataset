
module branchresolve(rt,rs,en,eqz,gez,gtz,lez,ltz,ne,eq);

  input  en;
  input  [31:0] rs;
  input  [31:0] rt;
  output eq;
  output ne;
  output ltz;
  output lez;
  output gtz;
  output gez;
  output eqz;

  assign eq = en & ((eqz | en) & (rs == rt));
  assign ne = en & ~eq;
  assign eqz = en & ((((~rs[31] & (en & rs[31])) | (((eqz & (en & rs[31])) | (~rs[31] & (en & rs[31]))) | (((en & (eqz | (en & rs[31]))) | (rs[31] & (eqz | (en & rs[31])))) & eqz))) | en) & ((eqz | en) & (~|rs & ((eqz | (en & rs[31])) | (((((~rs[31] & (en & rs[31])) | ((((en & (eqz | (en & rs[31]))) | (rs[31] & (eqz | (en & rs[31])))) & eqz) | (en & (eqz | (en & rs[31]))))) | rs[31]) | (((en & rs[31]) & ((rs[31] | eqz) & (~eqz & ~rs[31]))) | (eqz & (en & rs[31])))) | en)))));
  assign ltz = en & rs[31];
  assign lez = en & (eqz | (en & rs[31]));
  assign gtz = (~eqz & ((eqz | en) & (((((~rs[31] & (en & rs[31])) | ((((en & (eqz | (en & rs[31]))) | (rs[31] & (eqz | (en & rs[31])))) & eqz) | (en & (eqz | (en & rs[31]))))) | rs[31]) | (((en & rs[31]) & ((rs[31] | eqz) & (~eqz & ~rs[31]))) | (eqz & (en & rs[31])))) | en))) & (en & (~rs[31] & ((eqz | en) & (((((~rs[31] & (en & rs[31])) | ((((en & (eqz | (en & rs[31]))) | (rs[31] & (eqz | (en & rs[31])))) & eqz) | (en & (eqz | (en & rs[31]))))) | rs[31]) | (((en & rs[31]) & ((rs[31] | eqz) & (~eqz & ~rs[31]))) | (eqz & (en & rs[31])))) | en))));
  assign gez = en & (~rs[31] & ((eqz | en) & (((((~rs[31] & (en & rs[31])) | ((((en & (eqz | (en & rs[31]))) | (rs[31] & (eqz | (en & rs[31])))) & eqz) | (en & (eqz | (en & rs[31]))))) | rs[31]) | (((en & rs[31]) & ((rs[31] | eqz) & (~eqz & ~rs[31]))) | (eqz & (en & rs[31])))) | en)));
endmodule

