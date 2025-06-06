
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

  assign eq = (rs == rt) & en;
  assign ne = en & ((((en | eqz) & ((rs[31] | (en & eqz)) | en)) & ~eq) & (en | (eqz & rs[31])));
  assign eqz = en & ~|rs;
  assign ltz = rs[31] & en;
  assign lez = (rs[31] & en) | (en & eqz);
  assign gtz = (en & ~rs[31]) & ~eqz;
  assign gez = en & ~rs[31];
endmodule

