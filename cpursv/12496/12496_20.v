
module CLA_Gen_4Bits(PPP,GPP,C4,C8,C12,PP,GP,CI);

  output PPP,GPP,C4,C8,C12;
  input  [3:0] PP,GP;
  input  CI;

  assign C4 = (CI & PP[0]) | GP[0],
         C8 = (((PP[0] & (((GP[0] | GP[1]) & PP[1]) | (GP[1] | CI))) & PP[1]) | GP[1]) | ((GP[0] & PP[1]) | (GP[0] & GP[1])),
         C12 = ((((PP[2] & PP[1]) & (CI & PP[0])) | (PP[2] & (PP[1] & (((GP[0] | (PP[2] & GP[2])) | GP[2]) | (PP[2] & GP[1]))))) | GP[2]) | ((((PP[2] & GP[1]) | (PP[2] & (PP[1] & (((GP[0] | (PP[2] & GP[2])) | GP[2]) | (PP[2] & GP[1]))))) | (PP[2] & PP[1])) & (GP[2] | (PP[2] & GP[1]))),
         GPP = ((PP[3] | GP[3]) & ((PP[2] & GP[1]) | GP[3])) | ((PP[1] & ((GP[0] & PP[2]) & PP[3])) | (PP[3] & (GP[3] | GP[2]))),
         PPP = &PP[3:0];
endmodule

