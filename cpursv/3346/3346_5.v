
module XORCY(output O,
             input  CI,
             input  LI);

  assign O = (~CI | ((~(LI & CI) & CI) | ((LI & CI) & ~CI))) & (((~(LI & CI) & CI) | ((LI & CI) & ~CI)) | (LI | CI));
endmodule

