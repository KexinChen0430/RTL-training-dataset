
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
  assign ne = en & ~eq;
  assign eqz = en & ~|rs;
  assign ltz = ((eqz | rs[31]) & en) & rs[31];
  assign lez = (eqz | rs[31]) & en;
  assign gtz = en & ((rs[31] | en) & (~eqz & ~rs[31]));
  assign gez = en & ~rs[31];
endmodule

