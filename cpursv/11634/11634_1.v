
module v6_emac_v2_2(rx_axi_clk,glbl_rstn,rx_axis_mac_tuser,gmii_col,gmii_crs,
                    gmii_tx_en,tx_axi_rstn,gmii_tx_er,tx_collision,rx_axi_rstn,
                    tx_axis_mac_tlast,tx_retransmit,tx_axis_mac_tuser,
                    rx_axis_mac_tvalid,rx_statistics_valid,tx_statistics_valid,
                    rx_axis_mac_tlast,speed_is_10_100,gtx_clk,rx_reset_out,
                    tx_reset_out,tx_axi_clk,gmii_rx_dv,gmii_rx_er,
                    tx_axis_mac_tready,tx_axis_mac_tvalid,pause_req,
                    tx_statistics_vector,pause_val,rx_statistics_vector,gmii_rxd,
                    tx_ifg_delay,tx_axis_mac_tdata,rx_axis_mac_tdata,gmii_txd);

  input  rx_axi_clk;
  input  glbl_rstn;
  output rx_axis_mac_tuser;
  input  gmii_col;
  input  gmii_crs;
  output gmii_tx_en;
  input  tx_axi_rstn;
  output gmii_tx_er;
  output tx_collision;
  input  rx_axi_rstn;
  input  tx_axis_mac_tlast;
  output tx_retransmit;
  input  tx_axis_mac_tuser;
  output rx_axis_mac_tvalid;
  output rx_statistics_valid;
  output tx_statistics_valid;
  output rx_axis_mac_tlast;
  output speed_is_10_100;
  input  gtx_clk;
  output rx_reset_out;
  output tx_reset_out;
  input  tx_axi_clk;
  input  gmii_rx_dv;
  input  gmii_rx_er;
  output tx_axis_mac_tready;
  input  tx_axis_mac_tvalid;
  input  pause_req;
  output [31:0] tx_statistics_vector;
  input  [15:0] pause_val;
  output [27:0] rx_statistics_vector;
  input  [7:0] gmii_rxd;
  input  [7:0] tx_ifg_delay;
  input  [7:0] tx_axis_mac_tdata;
  output [7:0] rx_axis_mac_tdata;
  output [7:0] gmii_txd;


endmodule

