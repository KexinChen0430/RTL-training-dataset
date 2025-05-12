
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

  assign eq = (((((eqz | (~|rs & (en & rs[31]))) | (((rs == rt) & (en & rs[31])) | ((en & rs[31]) & (((eqz & en) | rs[31]) & ~eqz)))) | (rs[31] | en)) & (rs == rt)) & (en | (eqz | ((~rs[31] & en) & ((en & rs[31]) & (((eqz & en) | rs[31]) & ~eqz)))))) & en;
  assign ne = (~eq & (((((~rs[31] & en) & ((en & rs[31]) & (((eqz & en) | rs[31]) & ~eqz))) | ((eqz & rs[31]) | (eqz & en))) | (((~rs[31] & en) & ((en & rs[31]) & (((eqz & en) | rs[31]) & ~eqz))) | ((rs == rt) & (en & rs[31])))) | en)) & en;
  assign eqz = en & ~|rs;
  assign ltz = en & rs[31];
  assign lez = (eqz & en) | (en & rs[31]);
  assign gtz = ((((eqz | (~|rs & (en & rs[31]))) | (((rs == rt) & (en & rs[31])) | ((en & rs[31]) & (((eqz & en) | rs[31]) & ~eqz)))) | (rs[31] | en)) & (~eqz & ~rs[31])) & en;
  assign gez = ~rs[31] & en;
endmodule

