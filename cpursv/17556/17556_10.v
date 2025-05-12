
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
  assign ne = ~eq & en;
  assign eqz = ((en | (rs[31] & eqz)) & ~|rs) & en;
  assign ltz = rs[31] & en;
  assign lez = en & (eqz | rs[31]);
  assign gtz = ((((((rs[31] & en) & ((~eqz & rs[31]) & ~rs[31])) | ((en & (eqz | rs[31])) & (~eqz & eqz))) | ((~eqz & rs[31]) & en)) | (~eqz & rs[31])) | (en & ~eqz)) & (~rs[31] & en);
  assign gez = ~rs[31] & en;
endmodule

