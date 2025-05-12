
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

  assign eq = ((rs[31] | en) & (rs == rt)) & en;
  assign ne = en & (~eq & ((en | ((((((rs[31] & ((rs[31] | eqz) & ~eqz)) & ~rs[31]) & ((rs[31] | eqz) & en)) | (((rs[31] | eqz) & en) & eqz)) | ((rs[31] | en) & eqz)) | eqz)) & (rs[31] | en)));
  assign eqz = ((~|rs & (en | ((((((rs[31] & ((rs[31] | eqz) & ~eqz)) & ~rs[31]) & ((rs[31] | eqz) & en)) | (((rs[31] | eqz) & en) & eqz)) | ((rs[31] | en) & eqz)) | eqz))) & ((en | ((((((rs[31] & ((rs[31] | eqz) & ~eqz)) & ~rs[31]) & ((rs[31] | eqz) & en)) | (((rs[31] | eqz) & en) & eqz)) | ((rs[31] | en) & eqz)) | eqz)) & (rs[31] | en))) & en;
  assign ltz = en & rs[31];
  assign lez = (rs[31] | eqz) & en;
  assign gtz = ((rs[31] | en) & (~eqz & ~rs[31])) & en;
  assign gez = en & ((en | ((((((rs[31] & ((rs[31] | eqz) & ~eqz)) & ~rs[31]) & ((rs[31] | eqz) & en)) | (((rs[31] | eqz) & en) & eqz)) | ((rs[31] | en) & eqz)) | eqz)) & ~rs[31]);
endmodule

