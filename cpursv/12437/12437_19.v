
module CLA_Gen_2Bits(PPP,GPP,C4,PP,GP,CI);

  output PPP,GPP,C4;
  input  [1:0] PP,GP;
  input  CI;

  assign C4 = (CI & PP[0]) | GP[0],
         GPP = (((((((PP[1] | GP[1]) & ((PP[0] | CI) | (GP[0] | PP[0]))) & (GP[0] | PP[0])) & ((CI & PP[0]) | GP[0])) & PP[0]) & GP[0]) | (GP[0] & PP[1])) | ((PP[1] & (PP[0] & GP[0])) | GP[1]),
         PPP = (PP[1] & (GP[0] | PP[0])) & PP[0];
endmodule

