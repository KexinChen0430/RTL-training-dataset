
module XORCY(output O,
             input  CI,
             input  LI);

  assign O = LI ^ (((LI | ~LI) & CI) & (LI | ~LI));
endmodule

