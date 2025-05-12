
module Mxor(output out,
            input  a,b);

  assign out = ((a & ((~a | ((~a & (b & a)) | (a & ~(b & a)))) | b)) & ((~a | ((~a & (b & a)) | (a & ~(b & a)))) | b)) ^ b;
endmodule

