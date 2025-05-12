module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(if00_data_in, if00_load_in, if00_data_out,
  if00_load_out, if00_send_done, if00_send_busy, m00_axi_awaddr, m00_axi_awprot,
  m00_axi_awvalid, m00_axi_awready, m00_axi_wdata, m00_axi_wstrb, m00_axi_wvalid,
  m00_axi_wready, m00_axi_bresp, m00_axi_bvalid, m00_axi_bready, m00_axi_araddr,
  m00_axi_arprot, m00_axi_arvalid, m00_axi_arready, m00_axi_rdata, m00_axi_rresp,
  m00_axi_rvalid, m00_axi_rready, m00_axi_aclk, m00_axi_aresetn)
;
  input [7:0]if00_data_in; 
  input if00_load_in; 
  output [7:0]if00_data_out; 
  output if00_load_out; 
  input if00_send_done; 
  input if00_send_busy; 
  output [31:0]m00_axi_awaddr; 
  output [2:0]m00_axi_awprot; 
  output m00_axi_awvalid; 
  input m00_axi_awready; 
  output [31:0]m00_axi_wdata; 
  output [3:0]m00_axi_wstrb; 
  output m00_axi_wvalid; 
  input m00_axi_wready; 
  input [1:0]m00_axi_bresp; 
  input m00_axi_bvalid; 
  output m00_axi_bready; 
  output [31:0]m00_axi_araddr; 
  output [2:0]m00_axi_arprot; 
  output m00_axi_arvalid; 
  input m00_axi_arready; 
  input [31:0]m00_axi_rdata; 
  input [1:0]m00_axi_rresp; 
  input m00_axi_rvalid; 
  output m00_axi_rready; 
  input m00_axi_aclk; 
  input m00_axi_aresetn; 
endmodule