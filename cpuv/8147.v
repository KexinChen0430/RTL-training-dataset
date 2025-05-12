module OBUFDS_GTE4_ADV #(
`ifdef XIL_TIMING
  parameter LOC = "UNPLACED",
`endif
  parameter [0:0] REFCLK_EN_TX_PATH = 1'b0,
  parameter [4:0] REFCLK_ICNTL_TX = 5'b00000
)(
  output O,
  output OB,
  input CEB,
  input [3:0] I,
  input [1:0] RXRECCLK_SEL
);
  localparam MODULE_NAME = "OBUFDS_GTE4_ADV";
  reg trig_attr;
`ifdef XIL_DR
  `include "OBUFDS_GTE4_ADV_dr.v"
`else
  reg [0:0] REFCLK_EN_TX_PATH_REG = REFCLK_EN_TX_PATH;
  reg [4:0] REFCLK_ICNTL_TX_REG = REFCLK_ICNTL_TX;
`endif
`ifdef XIL_XECLIB
  reg glblGSR = 1'b0;
  reg glblGTS = glbl.GTS;
`else
  tri0 glblGSR = glbl.GSR;
  tri0 glblGTS = glbl.GTS;
`endif
  reg attr_err = 1'b0;
  reg  I_sel = 1'b0;
  always @(*) begin
    case (RXRECCLK_SEL)
      2'b00: I_sel <= I[0];
      2'b01: I_sel <= I[1];
      2'b10: I_sel <= I[2];
      2'b11: I_sel <= I[3];
      default : I_sel <= I[0];
     endcase
   end
  assign O = (~REFCLK_EN_TX_PATH_REG || (CEB === 1'b1) || glblGTS) ? 1'bz : I_sel;
  assign OB = (~REFCLK_EN_TX_PATH_REG || (CEB === 1'b1) || glblGTS) ? 1'bz : ~I_sel;
`ifndef XIL_XECLIB
`ifdef XIL_TIMING
  specify
    (CEB => O) = (0:0:0, 0:0:0);
    (CEB => OB) = (0:0:0, 0:0:0);
    (I[0] => O) = (0:0:0, 0:0:0);
    (I[0] => OB) = (0:0:0, 0:0:0);
    (I[1] => O) = (0:0:0, 0:0:0);
    (I[1] => OB) = (0:0:0, 0:0:0);
    (I[2] => O) = (0:0:0, 0:0:0);
    (I[2] => OB) = (0:0:0, 0:0:0);
    (I[3] => O) = (0:0:0, 0:0:0);
    (I[3] => OB) = (0:0:0, 0:0:0);
    specparam PATHPULSE$ = 0;
  endspecify
`endif
`endif
endmodule