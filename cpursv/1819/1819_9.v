
module Mxor(output out,
            input  a,b);

  assign out = (a ^ (a & b)) ^ (((~((a & ((~b | ~a) | b)) & b) & b) | ~b) & ((~((a & ((~b | ~a) | b)) & b) & b) | ((a & ((~b | ~a) | b)) & b)));
endmodule

