
module adder(output sumout,
             output cout,
             input  a,
             input  b,
             input  cin);

  assign sumout = (((cin & (~(a ^ b) & ((cin | (((a & b) ^ a) & ~b)) | (b & ~(a & b))))) | (~(((((b | a) & ~cin) & b) & ((~(a ^ b) | (~a & b)) | (~b | (~a & b)))) & (~cin & (((a & b) ^ a) & ~b))) & (((~cin & a) & ((~(a ^ b) | (~a & b)) | (~b | (~a & b)))) & (~cin & (((a & b) ^ a) & ~b))))) | (~(((~cin & a) & ((~(a ^ b) | (~a & b)) | (~b | (~a & b)))) & (~cin & (((a & b) ^ a) & ~b))) & (((((b | a) & ~cin) & b) & ((~(a ^ b) | (~a & b)) | (~b | (~a & b)))) & (~cin & (((a & b) ^ a) & ~b))))) | (~cin & (~a & b));
  assign cout = (b & cin) | ((cin | b) & a);
endmodule

