
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

  assign eq = ((((~rs[31] & ((en & rs[31]) & ((rs[31] | (eqz & en)) & ~eqz))) | ((eqz | (~rs[31] & ((en & rs[31]) & ((rs[31] | (eqz & en)) & ~eqz)))) | ((en & rs[31]) & ((rs[31] | (eqz & en)) & ~eqz)))) | (en | (rs[31] | (eqz & en)))) & (rs == rt)) & en;
  assign ne = en & ((en | ((rs[31] | (eqz & en)) & eqz)) & (((((eqz | ((en & ((rs == rt) & (eqz | (en & rs[31])))) & (en & rs[31]))) | ((eqz & en) | ((en & rs[31]) & ((eqz | rs[31]) & ~|rs)))) | en) & ~eq) & (en | (rs[31] | (eqz & en)))));
  assign eqz = ((((~rs[31] & ((en & rs[31]) & ((rs[31] | (eqz & en)) & ~eqz))) | ((eqz | (~rs[31] & ((en & rs[31]) & ((rs[31] | (eqz & en)) & ~eqz)))) | ((en & rs[31]) & ((rs[31] | (eqz & en)) & ~eqz)))) | (en | (rs[31] | (eqz & en)))) & ~|rs) & en;
  assign ltz = en & rs[31];
  assign lez = en & (eqz | (en & rs[31]));
  assign gtz = (~rs[31] & en) & (en & ~eqz);
  assign gez = ~rs[31] & en;
endmodule

