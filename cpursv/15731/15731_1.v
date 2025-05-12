
module adder(output sumout,
             output cout,
             input  a,
             input  b,
             input  cin);

  assign sumout = cin ^ (a ^ b);
  assign cout = ((b | cin) & (((~b & a) | (a & b)) | b)) & (cin | (a & b));
endmodule

