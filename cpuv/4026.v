module but used in infer_blkram_7series instantiation
  parameter ONECLOCK   = 0, 
  parameter REGRAM     = 0, 
  parameter MODE       = "READ_FIRST",
`ifdef NO_BRAM_READ_ENABLE
  parameter USE_READ_ENABLE = 0 
`else
  parameter USE_READ_ENABLE = 1 
`endif
) (
`ifdef ENABLE_ECC_DEBUG
  input                        ecc_rst, 
`endif 
  output reg [D_WIDTH - 1:0]   o, 
  input                        we, 
  input                        wclk, 
  input                        re, 
  input                        reg_ce, 
  input                        rclk, 
  input     [D_WIDTH - 1:0]    d, 
  input     [ADDR_WIDTH - 1:0] raddr, 
  input     [ADDR_WIDTH - 1:0] waddr 
);