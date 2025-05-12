
module Mxor(output out,
            input  a,b);

  assign out = (((((~a & (b & a)) | (a & ~(b & a))) & (a | ((((b | ~b) & a) & b) ^ b))) & (a | ((((b | ~b) & a) & b) ^ b))) & ~((((b | ~b) & a) & b) ^ b)) | (((((b | ~b) & a) & b) ^ b) & ~((((~a & (b & a)) | (a & ~(b & a))) & (a | ((((b | ~b) & a) & b) ^ b))) & (a | ((((b | ~b) & a) & b) ^ b))));
endmodule

