
module XORCY(output O,
             input  CI,
             input  LI);

  assign O = (~((~CI | CI) & ((CI & ((CI | LI) | ~LI)) & ((CI | LI) | ~LI))) & LI) | (~LI & ((~CI | CI) & ((CI & ((CI | LI) | ~LI)) & ((CI | LI) | ~LI))));
endmodule

