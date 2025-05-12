module IBUFDS_GTE4 #(
`ifdef XIL_TIMING
  parameter LOC = "UNPLACED",
`endif
  parameter [0:0] REFCLK_EN_TX_PATH = 1'b0,
  parameter [1:0] REFCLK_HROW_CK_SEL = 2'b00,
  parameter [1:0] REFCLK_ICNTL_RX = 2'b00
)(
  output O,
  output ODIV2,
  input CEB,
  input I,
  input IB
);
  localparam MODULE_NAME = "IBUFDS_GTE4";
  reg trig_attr = 1'b0;
`ifdef XIL_DR
  `include "IBUFDS_GTE4_dr.v"
`else
  reg [0:0] REFCLK_EN_TX_PATH_REG = REFCLK_EN_TX_PATH;
  reg [1:0] REFCLK_HROW_CK_SEL_REG = REFCLK_HROW_CK_SEL;
  reg [1:0] REFCLK_ICNTL_RX_REG = REFCLK_ICNTL_RX;
`endif
`ifdef XIL_ATTR_TEST
  reg attr_test = 1'b1;
`else
  reg attr_test = 1'b0;
`endif
  reg attr_err = 1'b0;
  tri0 glblGSR = glbl.GSR;
  reg  ODIV2_out = 1'b0;
  assign ODIV2   = ODIV2_out;
  reg [2:0] ce_count = 3'b001;
  reg [2:0] edge_count = 3'b000;
  reg allEqual = 1'b0;
  always @(posedge I) begin
    if (allEqual)
      edge_count <= 3'b000;
    else
      if ((CEB === 1'b0) || (CEB === 1'bz)) 
        edge_count <= edge_count + 1;
    end
  always @(edge_count)
    if (edge_count == ce_count)
      allEqual = 1;
    else
      allEqual = 0;
  always @(*) begin
    case (REFCLK_HROW_CK_SEL_REG)
      2'b00:    ODIV2_out <= ~(REFCLK_EN_TX_PATH_REG | (CEB === 1'b1)) && I;
      2'b01:    ODIV2_out <= allEqual;
      2'b10:    ODIV2_out <= 1'b0;
      2'b11:    ODIV2_out <= 1'b0;
      default : ODIV2_out <= ~(REFCLK_EN_TX_PATH_REG | (CEB === 1'b1)) && I;
    endcase
  end
  assign O = ~(REFCLK_EN_TX_PATH_REG | (CEB === 1'b1)) && I;
`ifndef XIL_XECLIB
  specify
    (I => O) = (100:100:100, 100:100:100);
    (I => ODIV2) = (100:100:100, 100:100:100);
    (IB => O) = (100:100:100, 100:100:100);
    (IB => ODIV2) = (100:100:100, 100:100:100);
    specparam PATHPULSE$ = 0;
  endspecify
`endif
endmodule