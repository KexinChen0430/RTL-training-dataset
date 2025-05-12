
module Mxor(output out,
            input  a,b);

  assign out = ((~b & ((~b | (b | a)) & a)) | ~((~b | (b | a)) & a)) & ((~b & ((~b | (b | a)) & a)) | b);
endmodule

