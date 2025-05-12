
module adder(output sumout,
             output cout,
             input  a,
             input  b,
             input  cin);

  assign sumout = ((b & ~a) & (~cin | ~((b ^ (a & b)) ^ ((a & b) ^ a)))) | ((~((b ^ (a & b)) ^ ((a & b) ^ a)) & cin) | (((((a & ~b) | a) | b) & (~cin & ~b)) & a));
  assign cout = ((a & cin) | (a & b)) | (cin & b);
endmodule

