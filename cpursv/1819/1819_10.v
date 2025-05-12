
module Mxor(output out,
            input  a,b);

  assign out = (b & ~a) | (((b & a) ^ (((b | ~b) & (a & (b | ~b))) & a)) & ~b);
endmodule

