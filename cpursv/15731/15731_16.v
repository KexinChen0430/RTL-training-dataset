
module adder(output sumout,
             output cout,
             input  a,
             input  b,
             input  cin);

  assign sumout = (~(a & ~cin) & (~cin & b)) | ((~cin | ~(a ^ b)) & ((~(~cin & b) & a) | (~(a ^ b) & cin)));
  assign cout = ((b | a) & cin) | ((cin & a) | (b & a));
endmodule

