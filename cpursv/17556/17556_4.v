
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

  assign eq = en & ((rs[31] | en) & ((rs == rt) & (en | (((en & (~eqz & (~rs[31] & rs[31]))) | ((rs[31] & eqz) & (eqz & en))) | eqz))));
  assign ne = en & ~eq;
  assign eqz = en & ((~|rs & (en | (((en & (~eqz & (~rs[31] & rs[31]))) | ((rs[31] & eqz) & (eqz & en))) | eqz))) & (rs[31] | en));
  assign ltz = rs[31] & en;
  assign lez = (rs[31] & en) | (eqz & en);
  assign gtz = (~eqz & (~rs[31] & (en | (((en & (~eqz & (~rs[31] & rs[31]))) | ((rs[31] & eqz) & (eqz & en))) | eqz)))) & en;
  assign gez = en & ~rs[31];
endmodule

