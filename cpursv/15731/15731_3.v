
module adder(output sumout,
             output cout,
             input  a,
             input  b,
             input  cin);

  assign sumout = (((((~cin & a) | ~((~b | ((b & a) ^ b)) & (((((b & a) | (~a & (~b & a))) | (~b & (~b & a))) | (b & (cin | ((b | (a & cin)) & a)))) | b))) & (~b | ~((~b | ((b & a) ^ b)) & (((((b & a) | (~a & (~b & a))) | (~b & (~b & a))) | (b & (cin | ((b | (a & cin)) & a)))) | b)))) | (((~cin & b) & ~(~cin & (b & a))) | (~(~cin & b) & (~cin & (b & a))))) & ((cin & ~((~b | ((b & a) ^ b)) & (((((b & a) | (~a & (~b & a))) | (~b & (~b & a))) | (b & (cin | ((b | (a & cin)) & a)))) | b))) | (~b & a))) | (((b & a) ^ b) & ((((~cin & a) | ~((~b | ((b & a) ^ b)) & (((((b & a) | (~a & (~b & a))) | (~b & (~b & a))) | (b & (cin | ((b | (a & cin)) & a)))) | b))) & (~b | ~((~b | ((b & a) ^ b)) & (((((b & a) | (~a & (~b & a))) | (~b & (~b & a))) | (b & (cin | ((b | (a & cin)) & a)))) | b)))) | (((~cin & b) & ~(~cin & (b & a))) | (~(~cin & b) & (~cin & (b & a))))));
  assign cout = (b & (cin | ((b | (a & cin)) & a))) | (a & cin);
endmodule

