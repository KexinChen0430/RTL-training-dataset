
module BypassCrossingWire(WGET,WVAL);

  parameter  width = 1;
  input  [width+(0-1):0] WVAL;
  output [width+(0-1):0] WGET;

  assign WGET = WVAL;
endmodule

