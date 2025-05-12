
module arbiter_ibus(wbm_adr_o,wbm_dat_o,wbm_sel_o,wbm_we_o,wbm_cyc_o,wbm_stb_o,
                    wbm_cti_o,wbm_bte_o,wbm_dat_i,wbm_ack_i,wbm_err_i,wbm_rty_i,
                    wbs0_adr_i,wbs0_dat_i,wbs0_sel_i,wbs0_we_i,wbs0_cyc_i,
                    wbs0_stb_i,wbs0_cti_i,wbs0_bte_i,wbs0_dat_o,wbs0_ack_o,
                    wbs0_err_o,wbs0_rty_o,wbs1_adr_i,wbs1_dat_i,wbs1_sel_i,
                    wbs1_we_i,wbs1_cyc_i,wbs1_stb_i,wbs1_cti_i,wbs1_bte_i,
                    wbs1_dat_o,wbs1_ack_o,wbs1_err_o,wbs1_rty_o,wb_clk,wb_rst);

  parameter  wb_dat_width = 32;
  parameter  wb_adr_width = 32;
  parameter  slave0_addr_width = 12;
  parameter  slave1_addr_width = 28;
  input  wb_clk;
  input  wb_rst;
  input  [(0-1)+wb_adr_width:0] wbm_adr_o;
  input  [(0-1)+wb_dat_width:0] wbm_dat_o;
  input  [3:0] wbm_sel_o;
  input  wbm_we_o;
  input  wbm_cyc_o;
  input  wbm_stb_o;
  input  [2:0] wbm_cti_o;
  input  [1:0] wbm_bte_o;
  output [(0-1)+wb_dat_width:0] wbm_dat_i;
  output wbm_ack_i;
  output wbm_err_i;
  output wbm_rty_i;
  output [(0-1)+wb_adr_width:0] wbs0_adr_i;
  output [(0-1)+wb_dat_width:0] wbs0_dat_i;
  output [3:0] wbs0_sel_i;
  output wbs0_we_i;
  output wbs0_cyc_i;
  output wbs0_stb_i;
  output [2:0] wbs0_cti_i;
  output [1:0] wbs0_bte_i;
  input  [(0-1)+wb_dat_width:0] wbs0_dat_o;
  input  wbs0_ack_o;
  input  wbs0_err_o;
  input  wbs0_rty_o;
  output [(0-1)+wb_adr_width:0] wbs1_adr_i;
  output [(0-1)+wb_dat_width:0] wbs1_dat_i;
  output [3:0] wbs1_sel_i;
  output wbs1_we_i;
  output wbs1_cyc_i;
  output wbs1_stb_i;
  output [2:0] wbs1_cti_i;
  output [1:0] wbs1_bte_i;
  input  [(0-1)+wb_dat_width:0] wbs1_dat_o;
  input  wbs1_ack_o;
  input  wbs1_err_o;
  input  wbs1_rty_o;
  wire [1:0] slave_sel;
  reg  watchdog_err;

  
  always @(posedge wb_clk)  watchdog_err <= 0;
  assign slave_sel[0] = ~|wbm_adr_o[(0-1)+wb_adr_width:slave0_addr_width];
  assign slave_sel[1] = ~|wbm_adr_o[(0-1)+wb_adr_width:slave1_addr_width] & ~slave_sel[0];
  assign wbs0_adr_i = wbm_adr_o;
  assign wbs0_dat_i = wbm_dat_o;
  assign wbs0_we_i = wbm_we_o;
  assign wbs0_sel_i = wbm_sel_o;
  assign wbs0_cti_i = wbm_cti_o;
  assign wbs0_bte_i = wbm_bte_o;
  assign wbs0_cyc_i = slave_sel[0] & wbm_cyc_o;
  assign wbs0_stb_i = wbm_stb_o & slave_sel[0];
  assign wbs1_adr_i = wbm_adr_o;
  assign wbs1_dat_i = wbm_dat_o;
  assign wbs1_we_i = wbm_we_o;
  assign wbs1_sel_i = wbm_sel_o;
  assign wbs1_cti_i = wbm_cti_o;
  assign wbs1_bte_i = wbm_bte_o;
  assign wbs1_cyc_i = slave_sel[1] & wbm_cyc_o;
  assign wbs1_stb_i = slave_sel[1] & wbm_stb_o;
  assign wbm_dat_i = slave_sel[1] ? wbs1_dat_o : wbs0_dat_o;
  assign wbm_ack_i = (wbs1_ack_o | (slave_sel[0] & (wbs0_ack_o | wbs1_ack_o))) & ((wbs0_ack_o & slave_sel[0]) | slave_sel[1]);
  assign wbm_err_i = ((wbs1_err_o | watchdog_err) | (slave_sel[0] & wbs0_err_o)) & ((slave_sel[0] & wbs0_err_o) | (slave_sel[1] | watchdog_err));
  assign wbm_rty_i = ((((wbs0_rty_o & slave_sel[1]) | (wbs0_rty_o & slave_sel[0])) | wbs1_rty_o) & (slave_sel[0] | wbs1_rty_o)) & (slave_sel[1] | ((wbs0_rty_o & slave_sel[0]) | (slave_sel[0] & slave_sel[1])));
endmodule

