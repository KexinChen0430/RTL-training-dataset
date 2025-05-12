module IBUF_ANALOG
`ifdef XIL_TIMING
#(
  parameter LOC = "UNPLACED"
)
`endif
(
  output O,
  input I
);
  localparam MODULE_NAME = "IBUF_ANALOG";
  tri0 glblGSR = glbl.GSR;
  assign O = I;
`ifndef XIL_XECLIB
`ifdef XIL_TIMING
specify
  (I => O) = (0:0:0, 0:0:0);
  specparam PATHPULSE$ = 0;
endspecify
`endif
`endif
endmodule