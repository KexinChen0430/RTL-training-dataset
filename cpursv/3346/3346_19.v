
module XORCY(output O,
             input  CI,
             input  LI);

  assign O = ((((LI & CI) & ~CI) | (~(LI & CI) & CI)) | ~CI) & (((LI & (LI & (CI & (LI | ~LI)))) ^ LI) | (LI | (((LI & CI) & ~CI) | (~(LI & CI) & CI))));
endmodule

