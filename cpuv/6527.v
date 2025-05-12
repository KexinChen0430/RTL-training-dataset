module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(aclk, aresetn, s_axi_awaddr, s_axi_awprot, 
  s_axi_awvalid, s_axi_awready, s_axi_wdata, s_axi_wstrb, s_axi_wvalid, s_axi_wready,
  s_axi_bresp, s_axi_bvalid, s_axi_bready, s_axi_araddr, s_axi_arprot, s_axi_arvalid,
  s_axi_arready, s_axi_rdata, s_axi_rresp, s_axi_rvalid, s_axi_rready, m_axi_awaddr,
  m_axi_awprot, m_axi_awvalid, m_axi_awready, m_axi_wdata, m_axi_wstrb, m_axi_wvalid,
  m_axi_wready, m_axi_bresp, m_axi_bvalid, m_axi_bready, m_axi_araddr, m_axi_arprot,
  m_axi_arvalid, m_axi_arready, m_axi_rdata, m_axi_rresp, m_axi_rvalid, m_axi_rready);
;
  input aclk; 
  input aresetn; 
  input [95:0]s_axi_awaddr; 
  input [8:0]s_axi_awprot; 
  input [2:0]s_axi_awvalid; 
  output [2:0]s_axi_awready; 
  input [95:0]s_axi_wdata; 
  input [11:0]s_axi_wstrb; 
  input [2:0]s_axi_wvalid; 
  output [2:0]s_axi_wready; 
  output [5:0]s_axi_bresp; 
  output [2:0]s_axi_bvalid; 
  input [2:0]s_axi_bready; 
  input [95:0]s_axi_araddr; 
  input [8:0]s_axi_arprot; 
  input [2:0]s_axi_arvalid; 
  output [2:0]s_axi_arready; 
  output [95:0]s_axi_rdata; 
  output [5:0]s_axi_rresp; 
  output [2:0]s_axi_rvalid; 
  input [2:0]s_axi_rready; 
  output [223:0]m_axi_awaddr; 
  output [20:0]m_axi_awprot; 
  output [6:0]m_axi_awvalid; 
  input [6:0]m_axi_awready; 
  output [223:0]m_axi_wdata; 
  output [27:0]m_axi_wstrb; 
  output [6:0]m_axi_wvalid; 
  input [6:0]m_axi_wready; 
  input [13:0]m_axi_bresp; 
  input [6:0]m_axi_bvalid; 
  output [6:0]m_axi_bready; 
  output [223:0]m_axi_araddr; 
  output [20:0]m_axi_arprot; 
  output [6:0]m_axi_arvalid; 
  input [6:0]m_axi_arready; 
  input [223:0]m_axi_rdata; 
  input [13:0]m_axi_rresp; 
  input [6:0]m_axi_rvalid; 
  output [6:0]m_axi_rready; 
endmodule