
module equation_sum(wb_adr_o,wb_dat_o,wb_sel_o,wb_we_o,wb_cyc_o,wb_stb_o,
                    wb_cti_o,wb_bte_o,equation_done,wb_clk,wb_rst,wb_dat_i,
                    wb_ack_i,wb_err_i,wb_rty_i,base_address,equation_enable);

  parameter  dw = 32;
  parameter  aw = 32;
  parameter  DEBUG = 0;
  input  wb_clk;
  input  wb_rst;
  output wire [aw-1:0] wb_adr_o;
  output wire [dw+(-1):0] wb_dat_o;
  output wire [3:0] wb_sel_o;
  output wire wb_we_o;
  output wire wb_cyc_o;
  output wire wb_stb_o;
  output wire [1<<<1:0] wb_cti_o;
  output wire [1:0] wb_bte_o;
  input  [dw+(-1):0] wb_dat_i;
  input  wb_ack_i;
  input  wb_err_i;
  input  wb_rty_i;
  input  [aw-1:0] base_address;
  input  equation_enable;
  output equation_done;

  assign wb_adr_o = {aw{equation_enable}} & 0;
  assign wb_dat_o = 0 & {dw{equation_enable}};
  assign wb_sel_o = 0 & equation_enable;
  assign wb_we_o = 0 & equation_enable;
  assign wb_cyc_o = 0 & equation_enable;
  assign wb_stb_o = 0 & equation_enable;
  assign wb_cti_o = 0 & equation_enable;
  assign wb_bte_o = 0 & equation_enable;
  assign equation_done = 0;
endmodule

