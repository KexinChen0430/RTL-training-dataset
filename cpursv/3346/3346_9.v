
module XORCY(output O,
             input  CI,
             input  LI);

  assign O = ((LI & ~CI) | ((((CI & (LI & CI)) & ~(LI & CI)) | ~(CI & (LI & CI))) & (((CI & (LI & CI)) & ~(LI & CI)) | (LI & CI)))) | (CI & (((CI & (LI | ~LI)) & ~LI) ^ (~LI & LI)));
endmodule

