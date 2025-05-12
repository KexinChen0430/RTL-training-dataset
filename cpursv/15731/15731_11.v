
module adder(output sumout,
             output cout,
             input  a,
             input  b,
             input  cin);

  assign sumout = ((~a & ((((b & cin) | (b & cin)) | a) | b)) | (a & ~b)) ^ cin;
  assign cout = (b & (((b & cin) | (b & cin)) | a)) | ((b & cin) | (a & cin));
endmodule

