module MASTER_JTAG
  `ifdef XIL_TIMING 
#(
  parameter LOC = "UNPLACED"
)
  `endif
(
  output TDO,
  input TCK,
  input TDI,
  input TMS
);
endmodule