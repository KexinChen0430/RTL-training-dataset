
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
  assign ne = en & ~eq;
  assign eqz = en & (((en | rs[31]) & (en | ((en & rs[31]) | eqz))) & ~|rs);
  assign ltz = en & rs[31];
  assign lez = ((eqz & (en | rs[31])) & en) | (en & rs[31]);
  assign gtz = ((en | ((en & rs[31]) | eqz)) & (~eqz & ((en | rs[31]) & ~rs[31]))) & en;
  assign gez = en & (((en | ((en & rs[31]) | eqz)) & ~rs[31]) & (en | (((((eqz & (en | rs[31])) & en) | (en & rs[31])) & ((rs == rt) & rs[31])) | (eqz & (en | rs[31])))));
endmodule

