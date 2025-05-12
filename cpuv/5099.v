module hdmi_design(
  clk100, 
  sw, 
  hdmi_rx_scl, 
  hdmi_rx_clk_n, 
  hdmi_rx_clk_p, 
  hdmi_rx_n, 
  hdmi_rx_p, 
  hdmi_tx_hpd, 
  led, 
  debug_pmod, 
  hdmi_rx_cec, 
  hdmi_rx_hpa, 
  hdmi_rx_sda, 
  hdmi_rx_txen, 
  hdmi_tx_cec, 
  hdmi_tx_clk_n, 
  hdmi_tx_clk_p, 
  hdmi_tx_rscl, 
  hdmi_tx_rsda, 
  hdmi_tx_p, 
  hdmi_tx_n, 
  rs232_tx 
);
  assign hdmi_rx_cec = 1'hz;
  assign hdmi_rx_sda = 1'hz;
  assign hdmi_tx_cec = 1'hz;
  assign hdmi_tx_rscl = 1'hz;
  assign hdmi_tx_rsda = 1'hz;
  assign led = 8'hzz;
  assign debug_pmod = 8'hzz;
  assign hdmi_rx_hpa = 1'hz;
  assign hdmi_rx_txen = 1'hz;
  assign hdmi_tx_clk_n = 1'hz;
  assign hdmi_tx_clk_p = 1'hz;
  assign hdmi_tx_p = 3'hz;
  assign hdmi_tx_n = 3'hz;
  assign rs232_tx = 1'hz;
endmodule