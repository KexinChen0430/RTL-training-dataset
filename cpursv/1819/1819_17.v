
module Mxor(output out,
            input  a,b);

  assign out = (~((~a | a) & (((b | ~b) & a) & (b | ~b))) & b) | (~b & ((~a | a) & (((b | ~b) & a) & (b | ~b))));
endmodule

