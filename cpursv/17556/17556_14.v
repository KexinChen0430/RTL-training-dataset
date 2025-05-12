
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

  assign eq = ((rs == rt) & (en | (((en & eqz) | rs[31]) & eqz))) & en;
  assign ne = en & ~eq;
  assign eqz = ((en | (((en & eqz) | rs[31]) & eqz)) & (~|rs & ((((eqz | ((rs[31] & en) & ((((rs[31] & en) | eqz) & rs[31]) & (rs == rt)))) | (((rs[31] & en) & (~|rs & rs[31])) | ((rs[31] & en) & (en & eqz)))) | en) & (en | ((en & eqz) | rs[31]))))) & en;
  assign ltz = rs[31] & en;
  assign lez = en & ((en & eqz) | rs[31]);
  assign gtz = (((((eqz | ((rs[31] & en) & ((((rs[31] & en) | eqz) & rs[31]) & (rs == rt)))) | (((rs[31] & en) & (~|rs & rs[31])) | ((rs[31] & en) & (en & eqz)))) | en) & ((((((((en & eqz) | ((rs[31] & en) & (~|rs & rs[31]))) | eqz) | (en | ((en & eqz) | rs[31]))) & ~rs[31]) & en) | (rs[31] & ~rs[31])) & ~eqz)) & (en | (((en & eqz) | rs[31]) & eqz))) & en;
  assign gez = (((((en & eqz) | ((rs[31] & en) & (~|rs & rs[31]))) | eqz) | (en | ((en & eqz) | rs[31]))) & ~rs[31]) & en;
endmodule

