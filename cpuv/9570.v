module zynq_design_1_axi_bram_ctrl_0_1(
  input s_axi_aclk, 
  input s_axi_aresetn, 
  input [11:0] s_axi_awid, 
  input [15:0] s_axi_awaddr, 
  input [7:0] s_axi_awlen, 
  input [2:0] s_axi_awsize, 
  input [1:0] s_axi_awburst, 
  input s_axi_awlock, 
  input [3:0] s_axi_awcache, 
  input [2:0] s_axi_awprot, 
  input s_axi_awvalid, 
  output s_axi_awready, 
  input [31:0] s_axi_wdata, 
  input [3:0] s_axi_wstrb, 
  input s_axi_wlast, 
  input s_axi_wvalid, 
  output s_axi_wready, 
  output [11:0] s_axi_bid, 
  output [1:0] s_axi_bresp, 
  output s_axi_bvalid, 
  input s_axi_bready, 
  input [11:0] s_axi_arid, 
  input [15:0] s_axi_araddr, 
  input [7:0] s_axi_arlen, 
  input [2:0] s_axi_arsize, 
  input [1:0] s_axi_arburst, 
  input s_axi_arlock, 
  input [3:0] s_axi_arcache, 
  input [2:0] s_axi_arprot, 
  input s_axi_arvalid, 
  output s_axi_arready, 
  output [11:0] s_axi_rid, 
  output [31:0] s_axi_rdata, 
  output [1:0] s_axi_rresp, 
  output s_axi_rlast, 
  output s_axi_rvalid, 
  input s_axi_rready, 
  output bram_rst_a, 
  output bram_clk_a, 
  output bram_en_a, 
  output [3:0] bram_we_a, 
  output [15:0] bram_addr_a, 
  output [31:0] bram_wrdata_a, 
  input [31:0] bram_rddata_a, 
  output bram_rst_b, 
  output bram_clk_b, 
  output bram_en_b, 
  output [3:0] bram_we_b, 
  output [15:0] bram_addr_b, 
  output [31:0] bram_wrdata_b, 
  input [31:0] bram_rddata_b 
);
;
endmodule