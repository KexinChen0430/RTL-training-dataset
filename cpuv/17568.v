module BUFG_GT_SYNC 
`ifdef XIL_TIMING 
#(
  parameter LOC = "UNPLACED" 
)
`endif 
(
  output CESYNC, 
  output CLRSYNC, 
  input CE, 
  input CLK, 
  input CLR 
);
  localparam MODULE_NAME = "BUFG_GT_SYNC"; 
  assign CESYNC = (CE === 1'bz) || CE; 
  assign CLRSYNC = (CLR !== 1'bz) && CLR; 
endmodule 