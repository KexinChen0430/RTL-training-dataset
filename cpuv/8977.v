module zynq_design_1_system_ila_0_0(clk, SLOT_0_AXI_awaddr, SLOT_0_AXI_awvalid,
  SLOT_0_AXI_awready, SLOT_0_AXI_wdata, SLOT_0_AXI_wstrb, SLOT_0_AXI_wvalid,
  SLOT_0_AXI_wready, SLOT_0_AXI_bresp, SLOT_0_AXI_bvalid, SLOT_0_AXI_bready,
  SLOT_0_AXI_araddr, SLOT_0_AXI_arvalid, SLOT_0_AXI_arready, SLOT_0_AXI_rdata,
  SLOT_0_AXI_rresp, SLOT_0_AXI_rvalid, SLOT_0_AXI_rready, resetn)
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
  input resetn; 
endmodule