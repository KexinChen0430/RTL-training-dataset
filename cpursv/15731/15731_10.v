
module adder(output sumout,
             output cout,
             input  a,
             input  b,
             input  cin);

  assign sumout = ((((cin | (((a & (b & (cin | a))) & ~b) & ~(((a | (b & ~a)) & ~b) & a))) | (~((a & (b & (cin | a))) & ~b) & (((a | (b & ~a)) & ~b) & a))) | (~a & (a | (b & ~a)))) & ((~(((~b | ((a | (b & ~a)) & ~b)) | (~a & (a | (b & ~a)))) & (a | (b & ~a))) | (~(((a & ~cin) & ((cin | a) | ~a)) & (b & (~a & ~cin))) & (((b & ~cin) & ((cin | a) | ~a)) & (b & (~a & ~cin))))) | ((((a & ~cin) & ((cin | a) | ~a)) & (b & (~a & ~cin))) & ~(((b & ~cin) & ((cin | a) | ~a)) & (b & (~a & ~cin)))))) | (a & (~b & ~cin));
  assign cout = (a & cin) | (b & (cin | a));
endmodule

