
module bd_mig_7series_0_0(ddr2_dq,ddr2_dqs_n,ddr2_dqs_p,ddr2_addr,ddr2_ba,ddr2_ras_n,
                          ddr2_cas_n,ddr2_we_n,ddr2_ck_p,ddr2_ck_n,ddr2_cke,ddr2_cs_n,
                          ddr2_dm,ddr2_odt,sys_clk_i,clk_ref_i,ui_clk,ui_clk_sync_rst,
                          ui_addn_clk_0,ui_addn_clk_1,ui_addn_clk_2,ui_addn_clk_3,
                          ui_addn_clk_4,mmcm_locked,aresetn,app_sr_active,app_ref_ack,
                          app_zq_ack,s_axi_awid,s_axi_awaddr,s_axi_awlen,s_axi_awsize,
                          s_axi_awburst,s_axi_awlock,s_axi_awcache,s_axi_awprot,
                          s_axi_awqos,s_axi_awvalid,s_axi_awready,s_axi_wdata,
                          s_axi_wstrb,s_axi_wlast,s_axi_wvalid,s_axi_wready,
                          s_axi_bready,s_axi_bid,s_axi_bresp,s_axi_bvalid,s_axi_arid,
                          s_axi_araddr,s_axi_arlen,s_axi_arsize,s_axi_arburst,
                          s_axi_arlock,s_axi_arcache,s_axi_arprot,s_axi_arqos,
                          s_axi_arvalid,s_axi_arready,s_axi_rready,s_axi_rid,
                          s_axi_rdata,s_axi_rresp,s_axi_rlast,s_axi_rvalid,
                          init_calib_complete,sys_rst);

  inout  [15:0] ddr2_dq;
  inout  [1:0] ddr2_dqs_n;
  inout  [1:0] ddr2_dqs_p;
  output [12:0] ddr2_addr;
  output [2:0] ddr2_ba;
  output ddr2_ras_n;
  output ddr2_cas_n;
  output ddr2_we_n;
  output ddr2_ck_p;
  output ddr2_ck_n;
  output ddr2_cke;
  output ddr2_cs_n;
  output [1:0] ddr2_dm;
  output ddr2_odt;
  input  sys_clk_i;
  input  clk_ref_i;
  output ui_clk;
  output ui_clk_sync_rst;
  output ui_addn_clk_0;
  output ui_addn_clk_1;
  output ui_addn_clk_2;
  output ui_addn_clk_3;
  output ui_addn_clk_4;
  output mmcm_locked;
  input  aresetn;
  output app_sr_active;
  output app_ref_ack;
  output app_zq_ack;
  input  [3:0] s_axi_awid;
  input  [31:0] s_axi_awaddr;
  input  [7:0] s_axi_awlen;
  input  [2:0] s_axi_awsize;
  input  [1:0] s_axi_awburst;
  input  s_axi_awlock;
  input  [3:0] s_axi_awcache;
  input  [2:0] s_axi_awprot;
  input  [3:0] s_axi_awqos;
  input  s_axi_awvalid;
  output s_axi_awready;
  input  [31:0] s_axi_wdata;
  input  [3:0] s_axi_wstrb;
  input  s_axi_wlast;
  input  s_axi_wvalid;
  output s_axi_wready;
  input  s_axi_bready;
  output [3:0] s_axi_bid;
  output [1:0] s_axi_bresp;
  output s_axi_bvalid;
  input  [3:0] s_axi_arid;
  input  [31:0] s_axi_araddr;
  input  [7:0] s_axi_arlen;
  input  [2:0] s_axi_arsize;
  input  [1:0] s_axi_arburst;
  input  s_axi_arlock;
  input  [3:0] s_axi_arcache;
  input  [2:0] s_axi_arprot;
  input  [3:0] s_axi_arqos;
  input  s_axi_arvalid;
  output s_axi_arready;
  input  s_axi_rready;
  output [3:0] s_axi_rid;
  output [31:0] s_axi_rdata;
  output [1:0] s_axi_rresp;
  output s_axi_rlast;
  output s_axi_rvalid;
  output init_calib_complete;
  input  sys_rst;


endmodule

