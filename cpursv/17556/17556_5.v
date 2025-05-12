
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

  assign eq = en & (((rs == rt) & ((eqz | ((((en & eqz) | (en & rs[31])) & (((rs[31] | (en & eqz)) & (rs == rt)) & rs[31])) | ((rs[31] & ((rs[31] | (en & eqz)) & (eqz | (en & rs[31])))) & (en & ~rs[31])))) | en)) & ((((((en & rs[31]) & eqz) | (~|rs & (en & rs[31]))) | (en & eqz)) | (eqz & (en | (rs[31] | (en & eqz))))) | en));
  assign ne = ((en | (rs[31] | (en & eqz))) & ((~eq & (en | (rs[31] | (en & eqz)))) & ((eqz | ((((en & eqz) | (en & rs[31])) & (((rs[31] | (en & eqz)) & (rs == rt)) & rs[31])) | ((rs[31] & ((rs[31] | (en & eqz)) & (eqz | (en & rs[31])))) & (en & ~rs[31])))) | en))) & en;
  assign eqz = en & ~|rs;
  assign ltz = en & rs[31];
  assign lez = (en & eqz) | (en & rs[31]);
  assign gtz = (en & ~rs[31]) & (((eqz | ((((en & eqz) | (en & rs[31])) & (((rs[31] | (en & eqz)) & (rs == rt)) & rs[31])) | ((rs[31] & ((rs[31] | (en & eqz)) & (eqz | (en & rs[31])))) & (en & ~rs[31])))) | en) & ~eqz);
  assign gez = en & ~rs[31];
endmodule

