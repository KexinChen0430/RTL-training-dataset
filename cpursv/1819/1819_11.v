
module Mxor(output out,
            input  a,b);

  assign out = (~b & (a | b)) | (b & ~a);
endmodule

