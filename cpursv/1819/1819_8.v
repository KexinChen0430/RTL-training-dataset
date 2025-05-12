
module Mxor(output out,
            input  a,b);

  assign out = ((~(a & b) & a) | ((a & b) & ~a)) | (~a & b);
endmodule

