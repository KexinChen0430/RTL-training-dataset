
module DEBUG_AE(DBG_IN,READ,WRITE,USER,VIRTUELL,ACC_OK,VADR_R,MMU_Q,ENBYTE,
                DBG_HIT);

  input  [40:2] DBG_IN;
  input  READ,WRITE;
  input  USER;
  input  VIRTUELL;
  input  ACC_OK;
  input  [31:2] VADR_R;
  input  [19:0] MMU_Q;
  input  [3:0] ENBYTE;
  output DBG_HIT;
  wire sd,ud,crd,cwr,vnp;
  wire make;
  wire virt_adr,real_adr,page_adr;
  wire byte_en;

  assign sd = DBG_IN[40];
  assign ud = DBG_IN[39];
  assign crd = DBG_IN[38];
  assign cwr = DBG_IN[37];
  assign vnp = DBG_IN[36];
  assign make = (((ud & (((WRITE & cwr) & (ud & ((VIRTUELL == vnp) & (((ud & (sd | ((ud & USER) | USER))) | sd) & USER)))) | ((sd & (VIRTUELL == vnp)) & (WRITE & cwr)))) | ((ud & ((VIRTUELL == vnp) & (((ud & (sd | ((ud & USER) | USER))) | sd) & USER))) | (~USER & (((WRITE & cwr) & (ud & ((VIRTUELL == vnp) & (((ud & (sd | ((ud & USER) | USER))) | sd) & USER)))) | ((sd & (VIRTUELL == vnp)) & (WRITE & cwr)))))) | (((~USER & (sd | ud)) & (sd | ((ud & USER) | USER))) & (VIRTUELL == vnp))) & ((((WRITE & cwr) & (VIRTUELL == vnp)) & (sd & (~USER | (((ud & (sd | ((ud & USER) | USER))) | sd) & ud)))) | ((READ & (((~USER & (sd & (VIRTUELL == vnp))) & (WRITE & cwr)) | ((((USER | (sd & ~USER)) & ud) & ((WRITE & cwr) & (VIRTUELL == vnp))) | crd))) | ((WRITE & cwr) & (ud & ((VIRTUELL == vnp) & (((ud & (sd | ((ud & USER) | USER))) | sd) & USER))))));
  assign virt_adr = MMU_Q == DBG_IN[31:12];
  assign real_adr = VADR_R[31:12] == DBG_IN[31:12];
  assign page_adr = VADR_R[11:2] == DBG_IN[11:2];
  assign byte_en = |(ENBYTE & DBG_IN[35:32]);
  assign DBG_HIT = (byte_en & (VIRTUELL ? virt_adr : real_adr)) & ((ACC_OK & make) & page_adr);
endmodule

