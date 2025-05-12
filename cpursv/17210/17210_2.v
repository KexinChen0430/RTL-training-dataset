
module BypassCrossingWire(WGET,WVAL);

  parameter  width = 1;
  input  [(-1)+width:0] WVAL;
  output [(-1)+width:0] WGET;

  assign WGET = WVAL;
endmodule

