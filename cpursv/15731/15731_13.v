
module adder(output sumout,
             output cout,
             input  a,
             input  b,
             input  cin);

  assign sumout = ((~(b ^ a) & ((b ^ a) | (cin & ~(b ^ a)))) | (~(((((~cin | ~cin) | (cin & ~(b ^ a))) & (a & ~cin)) & ((~b | a) | ((~a & b) | a))) & ((~b | a) | ((~a & b) | a))) & (((~b | a) | ((~a & b) | a)) & (((~b | a) | ((~a & b) | a)) & ((~cin & b) & ((~cin | ~cin) | (cin & ~(b ^ a)))))))) | (~(((~b | a) | ((~a & b) | a)) & (((~b | a) | ((~a & b) | a)) & ((~cin & b) & ((~cin | ~cin) | (cin & ~(b ^ a)))))) & (((((~cin | ~cin) | (cin & ~(b ^ a))) & (a & ~cin)) & ((~b | a) | ((~a & b) | a))) & ((~b | a) | ((~a & b) | a))));
  assign cout = ((b & a) | (a & cin)) | (b & cin);
endmodule

