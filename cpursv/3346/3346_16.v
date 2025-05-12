
module XORCY(output O,
             input  CI,
             input  LI);

  assign O = LI ^ (CI & (~LI | LI));
endmodule

