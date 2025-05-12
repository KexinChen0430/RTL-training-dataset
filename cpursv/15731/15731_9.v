
module adder(output sumout,
             output cout,
             input  a,
             input  b,
             input  cin);

  assign sumout = (((~((b & ((b & ~a) | ~b)) | ((b & (a & (cin | b))) ^ a)) & cin) | (b & ~a)) & ((~cin | ~cin) | (((a & ~b) | (cin | (b & ((b & ~a) | ~b)))) & ~((b & ((b & ~a) | ~b)) | ((b & (a & (cin | b))) ^ a))))) | (~cin & ((b & (a & (cin | b))) ^ a));
  assign cout = (b & (a & (cin | b))) | ((cin & a) | (cin & b));
endmodule

