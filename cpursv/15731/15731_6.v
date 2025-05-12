
module adder(output sumout,
             output cout,
             input  a,
             input  b,
             input  cin);

  assign sumout = ((((cin & (~(a & ~cin) & ((~cin & b) & (~(b ^ a) | ~cin)))) | (((~(b ^ a) | ((~cin & ~(~cin & b)) & (a & b))) | (((a & ~cin) & (~(b ^ a) | ~cin)) & ~(~cin & b))) & cin)) | ((a & b) & (~b & ~cin))) | (~cin & (a & ~b))) | (~cin & (~a & (((a & ~b) | a) | b)));
  assign cout = (cin | (a & b)) & ((cin & b) | a);
endmodule

