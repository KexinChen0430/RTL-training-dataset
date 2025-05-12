
module adder(output sumout,
             output cout,
             input  a,
             input  b,
             input  cin);

  assign sumout = ((~(((b & a) ^ b) | (~(b & a) & a)) & cin) | ((((a & ~cin) & (((~(b & a) & a) | ((b & a) & ~a)) | ((~a & b) | (~(((b & a) ^ b) | (~(b & a) & a)) & cin)))) & (((~(b & a) & a) | ((b & a) & ~a)) | ((~a & b) | (~(((b & a) ^ b) | (~(b & a) & a)) & cin)))) & ~(((~cin & b) & (((~(b & a) & a) | ((b & a) & ~a)) | ((~a & b) | (~(((b & a) ^ b) | (~(b & a) & a)) & cin)))) & (((~(b & a) & a) | ((b & a) & ~a)) | ((~a & b) | (~(((b & a) ^ b) | (~(b & a) & a)) & cin)))))) | ((((~cin & b) & (((~(b & a) & a) | ((b & a) & ~a)) | ((~a & b) | (~(((b & a) ^ b) | (~(b & a) & a)) & cin)))) & (((~(b & a) & a) | ((b & a) & ~a)) | ((~a & b) | (~(((b & a) ^ b) | (~(b & a) & a)) & cin)))) & ~(((a & ~cin) & (((~(b & a) & a) | ((b & a) & ~a)) | ((~a & b) | (~(((b & a) ^ b) | (~(b & a) & a)) & cin)))) & (((~(b & a) & a) | ((b & a) & ~a)) | ((~a & b) | (~(((b & a) ^ b) | (~(b & a) & a)) & cin)))));
  assign cout = ((b | cin) & (b | a)) & (a | ((b & a) | cin));
endmodule

