
module XORCY(output O,
             input  CI,
             input  LI);

  assign O = (~(CI & (~LI | LI)) & LI) | ((CI & (~LI | LI)) & ~LI);
endmodule

