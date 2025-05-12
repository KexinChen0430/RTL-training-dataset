
module XORCY(output O,
             input  CI,
             input  LI);

  assign O = ((((CI | LI) | ~LI) & (((CI | LI) | ~LI) & CI)) & (CI | ~CI)) ^ LI;
endmodule

