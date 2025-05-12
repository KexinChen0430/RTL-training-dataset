
module Muxer(muxed,sa,sb,a,b);

  input  sa;
  input  sb;
  output wire [71:0] muxed;
  input  [71:0] a;
  input  [71:0] b;

  assign muxed = (a & ((b | a) & {72{sa}})) | ((b & {72{sb}}) | ((b & ({72{sb}} & a)) | ({72{sa}} & (a & b))));
endmodule

