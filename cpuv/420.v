module ip_design_nco_0_0(
  input [5:0] s_axi_AXILiteS_AWADDR,   
  input s_axi_AXILiteS_AWVALID,        
  output s_axi_AXILiteS_AWREADY,       
  input [31:0] s_axi_AXILiteS_WDATA,   
  input [3:0] s_axi_AXILiteS_WSTRB,    
  input s_axi_AXILiteS_WVALID,         
  output s_axi_AXILiteS_WREADY,        
  output [1:0] s_axi_AXILiteS_BRESP,   
  output s_axi_AXILiteS_BVALID,        
  input s_axi_AXILiteS_BREADY,         
  input [5:0] s_axi_AXILiteS_ARADDR,   
  input s_axi_AXILiteS_ARVALID,        
  output s_axi_AXILiteS_ARREADY,       
  output [31:0] s_axi_AXILiteS_RDATA,  
  output [1:0] s_axi_AXILiteS_RRESP,   
  output s_axi_AXILiteS_RVALID,        
  input s_axi_AXILiteS_RREADY,         
  input ap_clk,                        
  input ap_rst_n                       
);
endmodule