
module CLA_Gen_4Bits(PPP,GPP,C4,C8,C12,PP,GP,CI);

  output PPP,GPP,C4,C8,C12;
  input  [3:0] PP,GP;
  input  CI;

  assign C4 = (PP[0] & CI) | GP[0],
         C8 = (((GP[0] & GP[1]) | (PP[1] & GP[0])) | GP[1]) | (((((GP[0] & GP[1]) | (PP[1] & GP[0])) | GP[1]) | (PP[1] & (PP[0] | (((GP[0] & GP[1]) | (PP[1] & GP[0])) | GP[1])))) & CI),
         C12 = (((PP[1] & GP[0]) & PP[2]) | (GP[1] & PP[2])) | (GP[2] | ((((PP[1] | GP[1]) & PP[0]) & (CI & PP[1])) & PP[2])),
         GPP = ((GP[3] | ((PP[1] & GP[0]) & (PP[2] & PP[3]))) | (PP[3] & (GP[2] | ((PP[1] & GP[0]) & (PP[2] & PP[3]))))) | ((PP[3] & ((PP[2] | GP[3]) | (GP[2] & PP[3]))) & (GP[3] | (((GP[2] & PP[3]) | (PP[1] & GP[1])) | GP[1]))),
         PPP = &PP[3:0];
endmodule

