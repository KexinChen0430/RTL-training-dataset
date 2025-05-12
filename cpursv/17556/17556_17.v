
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

  assign eq = ((en | ((eqz & ((rs[31] | en) & ((rs[31] & en) | eqz))) | ((en & ~rs[31]) & (((rs[31] & en) | eqz) & rs[31])))) & (rs == rt)) & en;
  assign ne = en & ((~eq & (rs[31] | en)) & ((en | ((rs[31] & en) | eqz)) & (rs[31] | en)));
  assign eqz = en & (~|rs & (en | ((rs[31] & en) | eqz)));
  assign ltz = rs[31] & en;
  assign lez = ((rs[31] & en) | eqz) & en;
  assign gtz = (~rs[31] & (((en & (~eqz & (en | ((rs[31] & en) | eqz)))) | (((en & (eqz & rs[31])) | (en & ((~eqz & ((rs[31] | (((rs[31] & en) | eqz) & en)) | eqz)) & rs[31]))) | (en & (~eqz & (en | ((rs[31] & en) | eqz)))))) | (rs[31] & en))) & ~eqz;
  assign gez = en & ~rs[31];
endmodule

