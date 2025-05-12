
module adder(output sumout,
             output cout,
             input  a,
             input  b,
             input  cin);

  assign sumout = ((((~(cin & (((b | ~((a & ((~b & a) | ~a)) | (b & ~a))) | (((b & cin) | (b & cin)) | a)) & (b & ~cin))) & ((((b | ~((a & ((~b & a) | ~a)) | (b & ~a))) | (((b & cin) | (b & cin)) | a)) & (a & ~cin)) & cin)) | ((cin & (((b | ~((a & ((~b & a) | ~a)) | (b & ~a))) | (((b & cin) | (b & cin)) | a)) & (b & ~cin))) & ~((((b | ~((a & ((~b & a) | ~a)) | (b & ~a))) | (((b & cin) | (b & cin)) | a)) & (a & ~cin)) & cin))) | (~((a & ((~b & a) | ~a)) | (b & ~a)) & cin)) | (~(((b | ~((a & ((~b & a) | ~a)) | (b & ~a))) | (((b & cin) | (b & cin)) | a)) & (((b | ~((a & ((~b & a) | ~a)) | (b & ~a))) | (((b & cin) | (b & cin)) | a)) & (a & ~cin))) & ((((b | ~((a & ((~b & a) | ~a)) | (b & ~a))) | (((b & cin) | (b & cin)) | a)) & (b & ~cin)) & ((b | ~((a & ((~b & a) | ~a)) | (b & ~a))) | (((b & cin) | (b & cin)) | a))))) | (~((((b | ~((a & ((~b & a) | ~a)) | (b & ~a))) | (((b & cin) | (b & cin)) | a)) & (b & ~cin)) & ((b | ~((a & ((~b & a) | ~a)) | (b & ~a))) | (((b & cin) | (b & cin)) | a))) & (((b | ~((a & ((~b & a) | ~a)) | (b & ~a))) | (((b & cin) | (b & cin)) | a)) & (((b | ~((a & ((~b & a) | ~a)) | (b & ~a))) | (((b & cin) | (b & cin)) | a)) & (a & ~cin))));
  assign cout = (b & cin) | (a & (cin | b));
endmodule

