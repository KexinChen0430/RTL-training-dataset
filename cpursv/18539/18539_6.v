
module Muxer(muxed,sa,sb,a,b);

  input  sa;
  input  sb;
  output wire [71:0] muxed;
  input  [71:0] a;
  input  [71:0] b;

  assign muxed = ((b | {72{sa}}) & ({72{sb}} | a)) & (((({72{sb}} & a) | (a & ({72{sa}} & (({72{sa}} | {72{sb}}) & (b | a))))) | ((b | {72{sa}}) & ({72{sb}} & a))) | (b & {72{sb}}));
endmodule

