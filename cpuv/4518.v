module FRAME_ECCE4
`ifdef XIL_TIMING
#(
  parameter LOC = "UNPLACED"
)
`endif
(
  output CRCERROR,
  output ECCERRORNOTSINGLE,
  output ECCERRORSINGLE,
  output ENDOFFRAME,
  output ENDOFSCAN,
  output [26:0] FAR,
  input [1:0] FARSEL,
  input ICAPBOTCLK,
  input ICAPTOPCLK
);
endmodule