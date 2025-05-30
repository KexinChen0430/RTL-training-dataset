
module Muxer(muxed,sa,sb,a,b);

  input  sa;
  input  sb;
  output wire [71:0] muxed;
  input  [71:0] a;
  input  [71:0] b;

  assign muxed = (b & {72{sb}}) | (({72{sa}} & (a & (a & (b | {72{sa}})))) | ((b & (a & (b | {72{sa}}))) & ({72{sb}} | {72{sa}})));
endmodule

