
module Mxor(output out,
            input  a,b);

  assign out = (a & (b | ~b)) ^ b;
endmodule

