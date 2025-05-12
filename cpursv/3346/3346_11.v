
module XORCY(output O,
             input  CI,
             input  LI);

  assign O = (((CI | ~CI) & ((~LI | LI) & CI)) & (CI | LI)) ^ LI;
endmodule

