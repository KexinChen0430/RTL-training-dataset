
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

  assign eq = en & (rs == rt);
  assign ne = ((en | (rs[31] | eqz)) & ~eq) & en;
  assign eqz = en & ~|rs;
  assign ltz = rs[31] & en;
  assign lez = ((rs[31] & en) | eqz) & en;
  assign gtz = (en & ((en | rs[31]) & ~rs[31])) & ~eqz;
  assign gez = en & ((en | rs[31]) & ~rs[31]);
endmodule

