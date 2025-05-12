
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

  assign eq = en & ((((((en & eqz) | (rs[31] & eqz)) | (~rs[31] & (en & rs[31]))) | (((((rs[31] | (en & eqz)) & ((((en & eqz) & rs[31]) | (eqz | (~eq & (en & rs[31])))) | en)) & ~|rs) & (en & rs[31])) | ((~rs[31] & (((rs[31] | (en & eqz)) & ~eqz) & rs[31])) & (en & rs[31])))) | en) & (((rs[31] | (en & eqz)) | en) & (((((en & eqz) & rs[31]) | (eqz | (~eq & (en & rs[31])))) | en) & (rs == rt))));
  assign ne = ((((rs[31] | (en & eqz)) | ((((en & eqz) & rs[31]) | (eqz | (~eq & (en & rs[31])))) | en)) & ~eq) & ((((en & eqz) & rs[31]) | (eqz | (~eq & (en & rs[31])))) | en)) & en;
  assign eqz = ~|rs & en;
  assign ltz = en & rs[31];
  assign lez = en & (eqz | (en & rs[31]));
  assign gtz = ((((((en & eqz) & rs[31]) | (eqz | (~eq & (en & rs[31])))) | en) & ~rs[31]) & en) & ((((((en & eqz) & rs[31]) | (eqz | (~eq & (en & rs[31])))) | en) & ((rs[31] | (en & eqz)) | en)) & ~eqz);
  assign gez = (((((en & eqz) & rs[31]) | (eqz | (~eq & (en & rs[31])))) | en) & ~rs[31]) & en;
endmodule

