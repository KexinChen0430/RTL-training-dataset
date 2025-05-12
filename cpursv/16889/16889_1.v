
module radio_bridge_ratechangefilter_4x_2ch_cw(clk,ce,decfiltbypass,interp_en,rx_i,rx_i_fullrate,rx_q,
                                               rx_q_fullrate,tx_i,tx_i_fullrate,tx_q,tx_q_fullrate);

  input  clk;
  input  ce;
  input  decfiltbypass;
  input  interp_en;
  input  [13:0] rx_i_fullrate;
  input  [13:0] rx_q_fullrate;
  input  [15:0] tx_i;
  input  [15:0] tx_q;
  output [13:0] rx_i;
  output [13:0] rx_q;
  output [15:0] tx_i_fullrate;
  output [15:0] tx_q_fullrate;


endmodule

