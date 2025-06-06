
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
  assign make = ((((sd & (((USER | ~USER) & (USER | sd)) & ~USER)) & (READ & crd)) | ((((READ & crd) | WRITE) & cwr) & (((ud | sd) & ((USER | sd) & ~USER)) | (((crd & (VIRTUELL == vnp)) & ((USER & ud) | ((~USER & ((sd | (ud & (USER | sd))) & ((VIRTUELL == vnp) & (WRITE & cwr)))) | (((USER & ud) & ((sd | (ud & (USER | sd))) & ((VIRTUELL == vnp) & (WRITE & cwr)))) | (((VIRTUELL == vnp) & ~USER) & sd))))) | (USER & ud))))) | ((READ & crd) & ((ud | (sd & (((USER | ~USER) & (USER | sd)) & ~USER))) & USER))) & (VIRTUELL == vnp);
  assign virt_adr = MMU_Q == DBG_IN[31:12];
  assign real_adr = VADR_R[31:12] == DBG_IN[31:12];
  assign page_adr = VADR_R[11:2] == DBG_IN[11:2];
  assign byte_en = |(DBG_IN[35:32] & ENBYTE);
  assign DBG_HIT = (byte_en & (page_adr & (ACC_OK & (VIRTUELL ? virt_adr : real_adr)))) & make;
endmodule

