module axi_traffic_gen_0(
  input s_axi_aclk,          
  input s_axi_aresetn,       
  output [31:0] m_axi_lite_ch1_awaddr,  
  output [2:0] m_axi_lite_ch1_awprot,   
  output m_axi_lite_ch1_awvalid,        
  input m_axi_lite_ch1_awready,         
  output [31:0] m_axi_lite_ch1_wdata,   
  output [3:0] m_axi_lite_ch1_wstrb,    
  output m_axi_lite_ch1_wvalid,         
  input m_axi_lite_ch1_wready,          
  input [1:0] m_axi_lite_ch1_bresp,     
  input m_axi_lite_ch1_bvalid,          
  output m_axi_lite_ch1_bready,         
  output done,                          
  output [31:0] status                  
);
endmodule