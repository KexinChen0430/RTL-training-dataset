module DPHY_DIFFINBUF #(
`ifdef XIL_TIMING
  parameter LOC = "UNPLACED", 
`endif
  parameter DIFF_TERM = "TRUE", 
  parameter ISTANDARD = "DEFAULT" 
)(
  output HSRX_O, 
  output LPRX_O_N, 
  output LPRX_O_P, 
  input HSRX_DISABLE, 
  input I, 
  input IB, 
  input LPRX_DISABLE 
);