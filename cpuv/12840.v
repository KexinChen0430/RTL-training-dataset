module zynq_design_1_system_ila_0(clk, SLOT_0_AXI_awaddr, SLOT_0_AXI_awvalid,
  SLOT_0_AXI_awready, SLOT_0_AXI_wdata, SLOT_0_AXI_wstrb, SLOT_0_AXI_wvalid,
  SLOT_0_AXI_wready, SLOT_0_AXI_bresp, SLOT_0_AXI_bvalid, SLOT_0_AXI_bready,
  SLOT_0_AXI_araddr, SLOT_0_AXI_arvalid, SLOT_0_AXI_arready, SLOT_0_AXI_rdata,
  SLOT_0_AXI_rresp, SLOT_0_AXI_rvalid, SLOT_0_AXI_rready, SLOT_1_GPIO_tri_o,
  SLOT_2_AXI_awid, SLOT_2_AXI_awaddr, SLOT_2_AXI_awlen, SLOT_2_AXI_awsize,
  SLOT_2_AXI_awburst, SLOT_2_AXI_awlock, SLOT_2_AXI_awcache, SLOT_2_AXI_awprot,
  SLOT_2_AXI_awqos, SLOT_2_AXI_awvalid, SLOT_2_AXI_awready, SLOT_2_AXI_wdata,
  SLOT_2_AXI_wstrb, SLOT_2_AXI_wlast, SLOT_2_AXI_wvalid, SLOT_2_AXI_wready, SLOT_2_AXI_bid,
  SLOT_2_AXI_bresp, SLOT_2_AXI_bvalid, SLOT_2_AXI_bready, SLOT_2_AXI_arid,
  SLOT_2_AXI_araddr, SLOT_2_AXI_arlen, SLOT_2_AXI_arsize, SLOT_2_AXI_arburst,
  SLOT_2_AXI_arlock, SLOT_2_AXI_arcache, SLOT_2_AXI_arprot, SLOT_2_AXI_arqos,
  SLOT_2_AXI_arvalid, SLOT_2_AXI_arready, SLOT_2_AXI_rid, SLOT_2_AXI_rdata,
  SLOT_2_AXI_rresp, SLOT_2_AXI_rlast, SLOT_2_AXI_rvalid, SLOT_2_AXI_rready, resetn,
  TRIG_IN_trig, TRIG_IN_ack, TRIG_OUT_trig, TRIG_OUT_ack)
;
  input clk; 
  input [8:0]SLOT_0_AXI_awaddr; 
  input SLOT_0_AXI_awvalid; 
  input SLOT_0_AXI_awready; 
  input [31:0]SLOT_0_AXI_wdata; 
  input [3:0]SLOT_0_AXI_wstrb; 
  input SLOT_0_AXI_wvalid; 
  input SLOT_0_AXI_wready; 
  input [1:0]SLOT_0_AXI_bresp; 
  input SLOT_0_AXI_bvalid; 
  input SLOT_0_AXI_bready; 
  input [8:0]SLOT_0_AXI_araddr; 
  input SLOT_0_AXI_arvalid; 
  input SLOT_0_AXI_arready; 
  input [31:0]SLOT_0_AXI_rdata; 
  input [1:0]SLOT_0_AXI_rresp; 
  input SLOT_0_AXI_rvalid; 
  input SLOT_0_AXI_rready; 
  input [7:0]SLOT_1_GPIO_tri_o; 
  input resetn; 
  input [0:0]TRIG_IN_trig; 
  output [0:0]TRIG_IN_ack; 
  output [0:0]TRIG_OUT_trig; 
  input [0:0]TRIG_OUT_ack; 
endmodule