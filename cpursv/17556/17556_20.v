
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

  assign eq = (((eqz | ((~eqz & en) & ((~rs[31] & (rs[31] | (en & eqz))) & (rs[31] & en)))) | ((((rs[31] | (en & eqz)) & eqz) | en) | rs[31])) & (rs == rt)) & en;
  assign ne = (~eq & ((en | eqz) & ((((rs[31] | (en & eqz)) & eqz) | en) | rs[31]))) & en;
  assign eqz = en & (~|rs & ((eqz | ((~eqz & en) & ((~rs[31] & (rs[31] | (en & eqz))) & (rs[31] & en)))) | ((((rs[31] | (en & eqz)) & eqz) | en) | rs[31])));
  assign ltz = rs[31] & en;
  assign lez = en & (rs[31] | (en & eqz));
  assign gtz = (~eqz & ~rs[31]) & en;
  assign gez = (((en | eqz) & ~rs[31]) & ((en | eqz) & ((((rs[31] | (en & eqz)) & eqz) | en) | rs[31]))) & en;
endmodule

