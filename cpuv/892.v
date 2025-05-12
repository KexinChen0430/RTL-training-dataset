module OBUFDS_GTE4 #(
  `ifdef XIL_TIMING
    parameter LOC = "UNPLACED",
  `endif
  parameter [0:0] REFCLK_EN_TX_PATH = 1'b0,
  parameter [4:0] REFCLK_ICNTL_TX = 5'b00000
)(
  output O,   
  output OB,  
  input CEB,  
  input I     
);
localparam MODULE_NAME = "OBUFDS_GTE4";
reg trig_attr;
`ifdef XIL_DR
  `include "OBUFDS_GTE4_dr.v"
`else
  reg [0:0] REFCLK_EN_TX_PATH_REG = REFCLK_EN_TX_PATH;
  reg [4:0] REFCLK_ICNTL_TX_REG = REFCLK_ICNTL_TX;
`endif
`ifdef XIL_XECLIB
  reg glblGSR = 1'b0;
  reg glblGTS = 1'b0;
`else
  tri0 glblGSR = glbl.GSR;
  tri0 glblGTS = glbl.GTS;
`endif
assign O = (~REFCLK_EN_TX_PATH_REG || (CEB === 1'b1) || glblGTS) ? 1'bz : I;
assign OB = (~REFCLK_EN_TX_PATH_REG || (CEB === 1'b1) || glblGTS) ? 1'bz : ~I;
`ifndef XIL_XECLIB
  `ifdef XIL_TIMING
    specify
      (I => O) = (0:0:0, 0:0:0);
      (I => OB) = (0:0:0, 0:0:0);
      specparam PATHPULSE$ = 0;
    endspecify
  `endif
`endif
endmodule