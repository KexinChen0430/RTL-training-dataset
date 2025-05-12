
module XORCY(output O,
             input  CI,
             input  LI);

  assign O = ((((~((CI & LI) & (LI | (CI ^ (CI & LI)))) & LI) | ~LI) & ((~((CI & LI) & (LI | (CI ^ (CI & LI)))) & LI) | ((CI & LI) & (LI | (CI ^ (CI & LI)))))) | (LI | (CI ^ (CI & LI)))) & ((((CI ^ (CI & LI)) & (~LI & LI)) | ~CI) | ~LI);
endmodule

