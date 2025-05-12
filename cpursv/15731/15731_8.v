
module adder(output sumout,
             output cout,
             input  a,
             input  b,
             input  cin);

  assign sumout = ((~cin & a) & ~(~cin & b)) | ((((~cin & ~a) | ~((b & ~a) | (~b & a))) | (~cin & ~b)) & (cin | (b & (~cin & ~(~cin & a)))));
  assign cout = ((((a & b) | cin) | a) & (a | b)) & (((a & cin) | (a & cin)) | b);
endmodule

