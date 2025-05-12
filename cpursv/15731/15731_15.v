
module adder(output sumout,
             output cout,
             input  a,
             input  b,
             input  cin);

  assign sumout = (((((cin | (((b & ~b) | (~(~a & (b & a)) & (~a & b))) | (~(~a & b) & (~a & (b & a))))) | (~b & (a & ~b))) | (~a & (a & ~b))) & ((a & ~cin) & ((a | b) | ~a))) ^ ((((a | b) | ~a) & (~cin & b)) & (((cin | (((b & ~b) | (~(~a & (b & a)) & (~a & b))) | (~(~a & b) & (~a & (b & a))))) | (~b & (a & ~b))) | (~a & (a & ~b))))) | ((cin & ~((a & ~b) | (~(b & a) & b))) | (cin & ~cin));
  assign cout = (cin & (a | b)) | ((b | cin) & a);
endmodule

