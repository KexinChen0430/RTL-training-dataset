module n64a_testpattern(
  VCLK,
  nDSYNC,
  nRST,
  vmode,
  Sync_in,
  vdata_out
);
`include "vh/n64a_params.vh"
input VCLK;
input nDSYNC;
input nRST;
input vmode;
input [3:0] Sync_in;
output [`VDATA_O_FU_SLICE] vdata_out;
wire posedge_nVSYNC = !vdata_out[3*color_width_o+3] &  Sync_in[3];
wire posedge_nHSYNC = !vdata_out[3*color_width_o+1] &  Sync_in[1];
wire posedge_nCSYNC = !vdata_out[3*color_width_o  ] &  Sync_in[0];
reg [8:0] vcnt = 9'b0;
reg [9:0] hcnt = 10'b0;
wire [8:0] pattern_vstart = vmode ? `TESTPAT_VSTART_PAL : `TESTPAT_VSTART_NTSC;
wire [8:0] pattern_vstop  = vmode ? `TESTPAT_VSTOP_PAL  : `TESTPAT_VSTOP_NTSC;
reg [4:0] vdata_checkboard_fine = 5'd0;
always @(posedge VCLK) begin
  if (!nDSYNC) begin
    if (posedge_nHSYNC) begin
      hcnt <= 10'b0;
      vcnt <= &vcnt ? vcnt : vcnt + 1'b1;
    end else begin
      hcnt <= &hcnt ? hcnt : hcnt + 1'b1;
    end
    if (posedge_nVSYNC)
      vcnt <= 9'b0;
    if ((vcnt > pattern_vstart) && (vcnt < pattern_vstop)) begin
      if ((hcnt > `TESTPAT_HSTART) && (hcnt < `TESTPAT_HSTOP))
        vdata_checkboard_fine[0] <= ~vdata_checkboard_fine[0];
      else
        vdata_checkboard_fine[0] <= 1'b0;
      if (hcnt == `TESTPAT_HSTART)
        vdata_checkboard_fine[0] <= vcnt[0];
    end else begin
      vdata_checkboard_fine[0] <= 1'b0;
    end
    vdata_checkboard_fine[4:1] <= Sync_in;
  end
  if (!nRST) begin
    vdata_checkboard_fine <= 5'd0;
    vcnt <= 9'b0;
    hcnt <= 10'b0;
  end
end
assign vdata_out = {vdata_checkboard_fine[4:1],{3*color_width_o{vdata_checkboard_fine[0]}}};
endmodule