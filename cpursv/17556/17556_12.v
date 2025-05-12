
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

  assign eq = en & ((en | eqz) & ((rs == rt) & (en | (rs[31] | eqz))));
  assign ne = en & ((en | (rs[31] | eqz)) & ~eq);
  assign eqz = ((en | eqz) & ~|rs) & en;
  assign ltz = en & rs[31];
  assign lez = en & (eqz | (en & rs[31]));
  assign gtz = ((~eqz & (en | (rs[31] | eqz))) & (en | eqz)) & (en & ~rs[31]);
  assign gez = en & ~rs[31];
endmodule

