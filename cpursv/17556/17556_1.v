
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

  assign eq = (((eqz | (rs[31] & en)) | (en | rs[31])) & (rs == rt)) & en;
  assign ne = en & (((en | rs[31]) & ((((~|rs & en) & ((eqz | (rs[31] & en)) & rs[31])) | (((eqz & en) | ((~|rs & en) & ((eqz | (rs[31] & en)) & rs[31]))) | eqz)) | en)) & ~eq);
  assign eqz = ~|rs & en;
  assign ltz = rs[31] & en;
  assign lez = en & ((en | rs[31]) & (eqz | (rs[31] & en)));
  assign gtz = (en & ~rs[31]) & ~eqz;
  assign gez = en & ~rs[31];
endmodule

