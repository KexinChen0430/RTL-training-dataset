module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(
  input [5:0]s_axi_HLS_MACC_PERIPH_BUS_AWADDR,   
  input s_axi_HLS_MACC_PERIPH_BUS_AWVALID,       
  output s_axi_HLS_MACC_PERIPH_BUS_AWREADY,      
  input [31:0]s_axi_HLS_MACC_PERIPH_BUS_WDATA,   
  input [3:0]s_axi_HLS_MACC_PERIPH_BUS_WSTRB,    
  input s_axi_HLS_MACC_PERIPH_BUS_WVALID,        
  output s_axi_HLS_MACC_PERIPH_BUS_WREADY,       
  output [1:0]s_axi_HLS_MACC_PERIPH_BUS_BRESP,   
  output s_axi_HLS_MACC_PERIPH_BUS_BVALID,       
  input s_axi_HLS_MACC_PERIPH_BUS_BREADY,        
  input [5:0]s_axi_HLS_MACC_PERIPH_BUS_ARADDR,   
  input s_axi_HLS_MACC_PERIPH_BUS_ARVALID,       
  output s_axi_HLS_MACC_PERIPH_BUS_ARREADY,      
  output [31:0]s_axi_HLS_MACC_PERIPH_BUS_RDATA,  
  output [1:0]s_axi_HLS_MACC_PERIPH_BUS_RRESP,   
  output s_axi_HLS_MACC_PERIPH_BUS_RVALID,       
  input s_axi_HLS_MACC_PERIPH_BUS_RREADY,        
  input ap_clk,                                  
  input ap_rst_n,                                
  output interrupt                               
);
;
endmodule