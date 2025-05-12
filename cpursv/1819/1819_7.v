
module Mxor(output out,
            input  a,b);

  assign out = b ^ (((a | b) | ~a) & (a & (~b | (a | b))));
endmodule

