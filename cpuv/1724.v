module DSP_PREADD
`ifdef XIL_TIMING
#(
  parameter LOC = "UNPLACED"
)
`endif
(
  output [26:0] AD,
  input ADDSUB,
  input [26:0] D_DATA,
  input INMODE2,
  input [26:0] PREADD_AB
);
  localparam MODULE_NAME = "DSP_PREADD";
`ifdef XIL_XECLIB
  reg glblGSR = 1'b0;
`else
  tri0 glblGSR = glbl.GSR;
`endif
`ifndef XIL_TIMING
  initial begin
    $display("Error: [Unisim %s-100] SIMPRIM primitive is not intended for direct instantiation in RTL or functional netlists. This primitive is only available in the SIMPRIM library for implemented netlists, please ensure you are pointing to the correct library. Instance %m", MODULE_NAME);
    #1 $finish;
  end
`endif
  wire [26:0] D_DATA_mux;
  assign D_DATA_mux = INMODE2    ? D_DATA    : 27'b0;
  assign AD = ADDSUB    ? (D_DATA_mux - PREADD_AB) : (D_DATA_mux + PREADD_AB);
`ifndef XIL_XECLIB
`ifdef XIL_TIMING
  specify
    (ADDSUB *> AD) = (0:0:0, 0:0:0);
    (D_DATA *> AD) = (0:0:0, 0:0:0);
    (INMODE2 *> AD) = (0:0:0, 0:0:0);
    (PREADD_AB *> AD) = (0:0:0, 0:0:0);
    specparam PATHPULSE$ = 0;
  endspecify
`endif
`endif
endmodule