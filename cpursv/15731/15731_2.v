
module adder(output sumout,
             output cout,
             input  a,
             input  b,
             input  cin);

  assign sumout = ((~cin & b) & ~(~cin & a)) | (((((~(((b & a) ^ b) | (~(b & a) & a)) | ((((~a | (a | (cin & b))) & (~cin & b)) & (~a | (a | (cin & b)))) & ~(((~a | (a | (cin & b))) & (~cin & a)) & (~a | (a | (cin & b)))))) | (~(((~a | (a | (cin & b))) & (~cin & b)) & (~a | (a | (cin & b)))) & (((~a | (a | (cin & b))) & (~cin & a)) & (~a | (a | (cin & b)))))) & cin) | (~((~cin & a) & ((~(~cin & b) & ~cin) & a)) & (((~(~cin & b) & ~cin) & a) & (~cin & b)))) | (~(((~(~cin & b) & ~cin) & a) & (~cin & b)) & ((~cin & a) & ((~(~cin & b) & ~cin) & a))));
  assign cout = (a | (cin & b)) & (b | (cin & a));
endmodule

