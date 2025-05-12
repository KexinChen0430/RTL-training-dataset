
module XORCY(output O,
             input  CI,
             input  LI);

  assign O = ((((CI ^ (LI & CI)) | LI) & ~LI) | ((CI ^ (LI & CI)) | ~CI)) & ((CI ^ (LI & CI)) | LI);
endmodule

