
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

  assign eq = (rs == rt) & en;
  assign ne = ~eq & en;
  assign eqz = ~|rs & en;
  assign ltz = rs[31] & en;
  assign lez = (((rs[31] & en) & ~eqz) | (eqz & en)) | (rs[31] & en);
  assign gtz = ~eqz & (((rs[31] & en) | (en & (~eqz & (((((~eqz & (~rs[31] & (rs[31] & en))) | ((rs[31] & en) & (eqz & en))) | eqz) | (en | (((((rs[31] & en) & ~eqz) | (eqz & en)) | (rs[31] & en)) | ((eqz | (rs[31] & en)) & rs[31])))) & ((rs[31] | (((rs[31] & en) & (eqz & en)) | (((eqz | (rs[31] & en)) & ~|rs) & (rs[31] & en)))) | en))))) & ~rs[31]);
  assign gez = en & (((((~eqz & (~rs[31] & (rs[31] & en))) | ((rs[31] & en) & (eqz & en))) | eqz) | (en | (((((rs[31] & en) & ~eqz) | (eqz & en)) | (rs[31] & en)) | ((eqz | (rs[31] & en)) & rs[31])))) & ~rs[31]);
endmodule

