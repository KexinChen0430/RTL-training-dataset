
module Mxor(output out,
            input  a,b);

  assign out = (a ^ (a & b)) | (~a & b);
endmodule

