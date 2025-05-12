
module XORCY(output O,
             input  CI,
             input  LI);

  assign O = (((LI & ~LI) & ~((CI & (~LI | (CI | LI))) & ~LI)) | (((CI & (~LI | (CI | LI))) & ~LI) & ~(LI & ~LI))) | (~CI & ((LI & (CI & (~LI | (CI | LI)))) ^ LI));
endmodule

