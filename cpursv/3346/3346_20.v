
module XORCY(output O,
             input  CI,
             input  LI);

  assign O = ((((~(LI & CI) & CI) | (~CI & (LI & CI))) & (LI | ((~(LI & CI) & CI) | (~CI & (LI & CI))))) & (LI | (((~(LI & CI) & CI) | (~CI & (LI & CI))) | ~CI))) ^ (((LI | ((~(LI & CI) & CI) | (~CI & (LI & CI)))) & (LI & CI)) ^ LI);
endmodule

