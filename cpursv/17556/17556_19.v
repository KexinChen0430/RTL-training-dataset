
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

  assign eq = ((((((((rs[31] & en) & ((en & ~|rs) & (eqz | ((rs[31] & en) | (en & eqz))))) | eqz) | ((~eqz & ~rs[31]) & (rs[31] & en))) | (rs[31] | en)) & (rs == rt)) & (eqz | en)) & (((rs[31] & eqz) | ((((~eqz & ~rs[31]) & (rs[31] & en)) | ((rs[31] & en) & (en & eqz))) | ((rs[31] & en) & (~rs[31] & ((((rs[31] & en) | (en & eqz)) | rs[31]) & (eqz | ((rs[31] & en) | (en & eqz)))))))) | en)) & en;
  assign ne = (((eqz | en) & ~eq) & (rs[31] | en)) & en;
  assign eqz = en & ~|rs;
  assign ltz = rs[31] & en;
  assign lez = (rs[31] & en) | (en & eqz);
  assign gtz = (((~eqz & (eqz | en)) & (((rs[31] & eqz) | ((((~eqz & ~rs[31]) & (rs[31] & en)) | ((rs[31] & en) & (en & eqz))) | ((rs[31] & en) & (~rs[31] & ((((rs[31] & en) | (en & eqz)) | rs[31]) & (eqz | ((rs[31] & en) | (en & eqz)))))))) | en)) & en) & ~rs[31];
  assign gez = (~rs[31] & (eqz | en)) & en;
endmodule

