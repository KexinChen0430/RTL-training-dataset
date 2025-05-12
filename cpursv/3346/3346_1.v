
module XORCY(output O,
             input  CI,
             input  LI);

  assign O = (((CI | LI) & (((~(CI & (((~LI | LI) & CI) & (CI | ~CI))) & (LI & CI)) | ~(LI & CI)) & ((~(CI & (((~LI | LI) & CI) & (CI | ~CI))) & (LI & CI)) | (CI & (((~LI | LI) & CI) & (CI | ~CI)))))) & (CI | LI)) ^ (((~LI & LI) & (((~(CI & (((~LI | LI) & CI) & (CI | ~CI))) & (LI & CI)) | ~(LI & CI)) & ((~(CI & (((~LI | LI) & CI) & (CI | ~CI))) & (LI & CI)) | (CI & (((~LI | LI) & CI) & (CI | ~CI)))))) | (~(LI & CI) & LI));
endmodule

