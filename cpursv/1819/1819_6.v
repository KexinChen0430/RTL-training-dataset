
module Mxor(output out,
            input  a,b);

  assign out = ((~a & b) | (b & ~b)) ^ (((a & ~(b & a)) | (~a & (b & a))) & ((~a & b) | a));
endmodule

