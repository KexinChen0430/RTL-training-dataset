
module altera_tse_alt4gxb_gige(cal_blk_clk,fixedclk,fixedclk_fast,gxb_powerdown,pll_inclk,
                               reconfig_clk,reconfig_togxb,rx_analogreset,rx_cruclk,
                               rx_datain,rx_digitalreset,rx_seriallpbken,tx_ctrlenable,
                               tx_datain,tx_digitalreset,reconfig_fromgxb,rx_clkout,
                               rx_ctrldetect,rx_dataout,rx_disperr,rx_errdetect,
                               rx_patterndetect,rx_rlv,rx_rmfifodatadeleted,
                               rx_rmfifodatainserted,rx_runningdisp,rx_syncstatus,tx_clkout,
                               tx_dataout);

  input  cal_blk_clk;
  input  fixedclk;
  input  [5:0] fixedclk_fast;
  input  gxb_powerdown;
  input  pll_inclk;
  input  reconfig_clk;
  input  [3:0] reconfig_togxb;
  input  rx_analogreset;
  input  rx_cruclk;
  input  rx_datain;
  input  rx_digitalreset;
  input  rx_seriallpbken;
  input  tx_ctrlenable;
  input  [7:0] tx_datain;
  input  tx_digitalreset;
  output [16:0] reconfig_fromgxb;
  output rx_clkout;
  output rx_ctrldetect;
  output [7:0] rx_dataout;
  output rx_disperr;
  output rx_errdetect;
  output rx_patterndetect;
  output rx_rlv;
  output rx_rmfifodatadeleted;
  output rx_rmfifodatainserted;
  output rx_runningdisp;
  output rx_syncstatus;
  output tx_clkout;
  output tx_dataout;
  tri0 rx_cruclk;
  parameter  starting_channel_number = 0;


endmodule

