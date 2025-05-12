module gcd_block_design_gcd_0_1(
  s_axi_gcd_bus_AWADDR,   
  s_axi_gcd_bus_AWVALID,  
  s_axi_gcd_bus_AWREADY,  
  s_axi_gcd_bus_WDATA,    
  s_axi_gcd_bus_WSTRB,    
  s_axi_gcd_bus_WVALID,   
  s_axi_gcd_bus_WREADY,   
  s_axi_gcd_bus_BRESP,    
  s_axi_gcd_bus_BVALID,   
  s_axi_gcd_bus_BREADY,   
  s_axi_gcd_bus_ARADDR,   
  s_axi_gcd_bus_ARVALID,  
  s_axi_gcd_bus_ARREADY,  
  s_axi_gcd_bus_RDATA,    
  s_axi_gcd_bus_RRESP,    
  s_axi_gcd_bus_RVALID,   
  s_axi_gcd_bus_RREADY,   
  ap_clk,                 
  ap_rst_n,               
  interrupt               
)
;
  input [5:0]s_axi_gcd_bus_AWADDR;   
  input s_axi_gcd_bus_AWVALID;       
  output s_axi_gcd_bus_AWREADY;      
  input [31:0]s_axi_gcd_bus_WDATA;   
  input [3:0]s_axi_gcd_bus_WSTRB;    
  input s_axi_gcd_bus_WVALID;        
  output s_axi_gcd_bus_WREADY;       
  output [1:0]s_axi_gcd_bus_BRESP;   
  output s_axi_gcd_bus_BVALID;       
  input s_axi_gcd_bus_BREADY;        
  input [5:0]s_axi_gcd_bus_ARADDR;   
  input s_axi_gcd_bus_ARVALID;       
  output s_axi_gcd_bus_ARREADY;      
  output [31:0]s_axi_gcd_bus_RDATA;  
  output [1:0]s_axi_gcd_bus_RRESP;   
  output s_axi_gcd_bus_RVALID;       
  input s_axi_gcd_bus_RREADY;        
  input ap_clk;                      
  input ap_rst_n;                    
  output interrupt;                  
endmodule