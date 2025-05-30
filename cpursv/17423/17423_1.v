
module ddr3_int_phy(pll_ref_clk,global_reset_n,soft_reset_n,ctl_dqs_burst,
                    ctl_wdata_valid,ctl_wdata,ctl_dm,ctl_addr,ctl_ba,ctl_cas_n,
                    ctl_cke,ctl_cs_n,ctl_odt,ctl_ras_n,ctl_we_n,ctl_rst_n,
                    ctl_mem_clk_disable,ctl_doing_rd,ctl_cal_req,
                    ctl_cal_byte_lane_sel_n,oct_ctl_rs_value,oct_ctl_rt_value,
                    dqs_offset_delay_ctrl,dqs_delay_ctrl_import,dbg_clk,
                    dbg_reset_n,dbg_addr,dbg_wr,dbg_rd,dbg_cs,dbg_wr_data,
                    reset_request_n,ctl_clk,ctl_reset_n,ctl_wlat,ctl_rdata,
                    ctl_rdata_valid,ctl_rlat,ctl_cal_success,ctl_cal_fail,
                    ctl_cal_warning,mem_addr,mem_ba,mem_cas_n,mem_cke,mem_cs_n,
                    mem_dm,mem_odt,mem_ras_n,mem_we_n,mem_reset_n,
                    dqs_delay_ctrl_export,dll_reference_clk,dbg_rd_data,
                    dbg_waitrequest,aux_half_rate_clk,aux_full_rate_clk,mem_clk,
                    mem_clk_n,mem_dq,mem_dqs,mem_dqs_n);

  input  pll_ref_clk;
  input  global_reset_n;
  input  soft_reset_n;
  input  [7:0] ctl_dqs_burst;
  input  [7:0] ctl_wdata_valid;
  input  [127:0] ctl_wdata;
  input  [15:0] ctl_dm;
  input  [27:0] ctl_addr;
  input  [5:0] ctl_ba;
  input  [1:0] ctl_cas_n;
  input  [1:0] ctl_cke;
  input  [1:0] ctl_cs_n;
  input  [1:0] ctl_odt;
  input  [1:0] ctl_ras_n;
  input  [1:0] ctl_we_n;
  input  [1:0] ctl_rst_n;
  input  ctl_mem_clk_disable;
  input  [7:0] ctl_doing_rd;
  input  ctl_cal_req;
  input  [3:0] ctl_cal_byte_lane_sel_n;
  input  [13:0] oct_ctl_rs_value;
  input  [13:0] oct_ctl_rt_value;
  input  [5:0] dqs_offset_delay_ctrl;
  input  [5:0] dqs_delay_ctrl_import;
  input  dbg_clk;
  input  dbg_reset_n;
  input  [12:0] dbg_addr;
  input  dbg_wr;
  input  dbg_rd;
  input  dbg_cs;
  input  [31:0] dbg_wr_data;
  output reset_request_n;
  output ctl_clk;
  output ctl_reset_n;
  output [4:0] ctl_wlat;
  output [127:0] ctl_rdata;
  output [1:0] ctl_rdata_valid;
  output [4:0] ctl_rlat;
  output ctl_cal_success;
  output ctl_cal_fail;
  output ctl_cal_warning;
  output [13:0] mem_addr;
  output [2:0] mem_ba;
  output mem_cas_n;
  output mem_cke;
  output mem_cs_n;
  output [3:0] mem_dm;
  output mem_odt;
  output mem_ras_n;
  output mem_we_n;
  output mem_reset_n;
  output [5:0] dqs_delay_ctrl_export;
  output dll_reference_clk;
  output [31:0] dbg_rd_data;
  output dbg_waitrequest;
  output aux_half_rate_clk;
  output aux_full_rate_clk;
  inout  mem_clk;
  inout  mem_clk_n;
  inout  [31:0] mem_dq;
  inout  [3:0] mem_dqs;
  inout  [3:0] mem_dqs_n;


endmodule

