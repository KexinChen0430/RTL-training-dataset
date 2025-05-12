module GTX_DRP_CHANALIGN_FIX_3752_V6
#(
  parameter       TCQ             = 1,
  parameter       C_SIMULATION    = 0 
)
(
  output  reg          dwe,
  output  reg  [15:0]  din,    
  output  reg          den,
  output  reg  [7:0]   daddr,
  output  reg  [3:0]   drpstate,
  input                write_ts1,
  input                write_fts,
  input       [15:0]   dout,  
  input                drdy,
  input                Reset_n,
  input                drp_clk
);