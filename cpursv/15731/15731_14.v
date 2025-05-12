
module adder(output sumout,
             output cout,
             input  a,
             input  b,
             input  cin);

  assign sumout = (((((~(((b | ~b) & ((~a & (b & a)) | (~(b & a) & a))) ^ ((~a & b) | (b & ~b))) | ((cin | ((a & ((b | a) & ~b)) & ~a)) | (a & ((b | a) & ~b)))) | ((~a & b) | (b & ~b))) & (a & ~cin)) & ~(((~(((b | ~b) & ((~a & (b & a)) | (~(b & a) & a))) ^ ((~a & b) | (b & ~b))) | ((cin | ((a & ((b | a) & ~b)) & ~a)) | (a & ((b | a) & ~b)))) | ((~a & b) | (b & ~b))) & (b & ~cin))) | ((((~(((b | ~b) & ((~a & (b & a)) | (~(b & a) & a))) ^ ((~a & b) | (b & ~b))) | ((cin | ((a & ((b | a) & ~b)) & ~a)) | (a & ((b | a) & ~b)))) | ((~a & b) | (b & ~b))) & (b & ~cin)) & ~(((~(((b | ~b) & ((~a & (b & a)) | (~(b & a) & a))) ^ ((~a & b) | (b & ~b))) | ((cin | ((a & ((b | a) & ~b)) & ~a)) | (a & ((b | a) & ~b)))) | ((~a & b) | (b & ~b))) & (a & ~cin)))) | (~(((b | ~b) & ((~a & (b & a)) | (~(b & a) & a))) ^ ((~a & b) | (b & ~b))) & (((a & ((b | a) & ~b)) | (cin & ~(((b | ~b) & ((~a & (b & a)) | (~(b & a) & a))) ^ ((~a & b) | (b & ~b))))) | (~a & b)));
  assign cout = (a | (cin | ((b | (a & cin)) & a))) & (b | (a & cin));
endmodule

