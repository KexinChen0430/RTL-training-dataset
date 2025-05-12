
module Mxor(output out,
            input  a,b);

  assign out = ((((~b | b) & ((~b | b) & a)) & (~b | b)) & ~b) | (~(((~b | b) & ((~b | b) & a)) & (~b | b)) & b);
endmodule

