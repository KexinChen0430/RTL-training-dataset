
module BypassCrossingWire(WGET,WVAL);

  parameter  width = 1;
  input  [(0-1)+width:0] WVAL;
  output [(0-1)+width:0] WGET;

  assign WGET = WVAL;
endmodule

