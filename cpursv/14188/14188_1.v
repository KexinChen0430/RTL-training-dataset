
module aurora_64b66b_25p4G(s_axi_tx_tdata,s_axi_tx_tlast,s_axi_tx_tkeep,s_axi_tx_tvalid,
                           s_axi_tx_tready,m_axi_rx_tdata,m_axi_rx_tlast,m_axi_rx_tkeep,
                           m_axi_rx_tvalid,rxp,rxn,txp,txn,refclk1_in,hard_err,soft_err,
                           channel_up,lane_up,mmcm_not_locked,user_clk,sync_clk,reset_pb,
                           gt_rxcdrovrden_in,power_down,loopback,pma_init,gt_pll_lock,
                           gt_qpllclk_quad1_in,gt_qpllrefclk_quad1_in,
                           gt_qplllock_quad1_in,gt_qpllrefclklost_quad1,
                           gt_to_common_qpllreset_out,s_axi_awaddr,s_axi_awvalid,
                           s_axi_awready,s_axi_wdata,s_axi_wstrb,s_axi_wvalid,
                           s_axi_wready,s_axi_bvalid,s_axi_bresp,s_axi_bready,
                           s_axi_araddr,s_axi_arvalid,s_axi_arready,s_axi_rdata,
                           s_axi_rvalid,s_axi_rresp,s_axi_rready,init_clk,link_reset_out,
                           gt_powergood,sys_reset_out,bufg_gt_clr_out,tx_out_clk);

  input  [0:63] s_axi_tx_tdata;
  input  s_axi_tx_tlast;
  input  [0:7] s_axi_tx_tkeep;
  input  s_axi_tx_tvalid;
  output s_axi_tx_tready;
  output [0:63] m_axi_rx_tdata;
  output m_axi_rx_tlast;
  output [0:7] m_axi_rx_tkeep;
  output m_axi_rx_tvalid;
  input  rxp;
  input  rxn;
  output txp;
  output txn;
  input  refclk1_in;
  output hard_err;
  output soft_err;
  output channel_up;
  output lane_up;
  input  mmcm_not_locked;
  input  user_clk;
  input  sync_clk;
  input  reset_pb;
  input  gt_rxcdrovrden_in;
  input  power_down;
  input  [2:0] loopback;
  input  pma_init;
  output gt_pll_lock;
  input  gt_qpllclk_quad1_in;
  input  gt_qpllrefclk_quad1_in;
  input  gt_qplllock_quad1_in;
  input  gt_qpllrefclklost_quad1;
  output gt_to_common_qpllreset_out;
  input  [31:0] s_axi_awaddr;
  input  s_axi_awvalid;
  output s_axi_awready;
  input  [31:0] s_axi_wdata;
  input  [3:0] s_axi_wstrb;
  input  s_axi_wvalid;
  output s_axi_wready;
  output s_axi_bvalid;
  output [1:0] s_axi_bresp;
  input  s_axi_bready;
  input  [31:0] s_axi_araddr;
  input  s_axi_arvalid;
  output s_axi_arready;
  output [31:0] s_axi_rdata;
  output s_axi_rvalid;
  output [1:0] s_axi_rresp;
  input  s_axi_rready;
  input  init_clk;
  output link_reset_out;
  output gt_powergood;
  output sys_reset_out;
  output bufg_gt_clr_out;
  output tx_out_clk;


endmodule

