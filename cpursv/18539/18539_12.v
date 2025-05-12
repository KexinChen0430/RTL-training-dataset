
module Muxer(muxed,sa,sb,a,b);

  input  sa;
  input  sb;
  output wire [71:0] muxed;
  input  [71:0] a;
  input  [71:0] b;

  assign muxed = ((({72{sb}} & {72{sa}}) & (a | b)) | ({72{sb}} & b)) | ({72{sa}} & a);
endmodule

