
module adder(output sumout,
             output cout,
             input  a,
             input  b,
             input  cin);

  assign sumout = (((cin & (((a | ~(a ^ b)) & (~(a ^ b) | (~cin & ~b))) | ~cin)) | (((b | (((cin & b) | (cin & b)) | ((a & cin) | (a & b)))) | (((a & b) | (~a & (~b & a))) | (~b & (~b & a)))) & ~b)) | (((b | (((cin & b) | (cin & b)) | ((a & cin) | (a & b)))) | (((a & b) | (~a & (~b & a))) | (~b & (~b & a)))) & ~a)) & (((a | ~(a ^ b)) & (~(a ^ b) | (~cin & ~b))) | ~cin);
  assign cout = ((cin & b) | (cin & b)) | ((a & cin) | (a & b));
endmodule

