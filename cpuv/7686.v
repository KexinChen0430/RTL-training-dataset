module module_1_coprocessor_0_wrapper
  (
    LED_OUT,       
    SW_IN,         
    BTN_IN,        
    S_AXI_ACLK,    
    S_AXI_ARESETN, 
    S_AXI_AWADDR,  
    S_AXI_AWVALID, 
    S_AXI_WDATA,   
    S_AXI_WSTRB,   
    S_AXI_WVALID,  
    S_AXI_BREADY,  
    S_AXI_ARADDR,  
    S_AXI_ARVALID, 
    S_AXI_RREADY,  
    S_AXI_ARREADY,
    S_AXI_RDATA,   
    S_AXI_RRESP,   
    S_AXI_RVALID,  
    S_AXI_WREADY,  
    S_AXI_BRESP,   
    S_AXI_BVALID,  
    S_AXI_AWREADY, 
    S_AXI_AWID,
    S_AXI_AWLEN,   
    S_AXI_AWSIZE,  
    S_AXI_AWBURST, 
    S_AXI_AWLOCK,  
    S_AXI_AWCACHE, 
    S_AXI_AWPROT,  
    S_AXI_WLAST,   
    S_AXI_BID,
    S_AXI_ARID,    
    S_AXI_ARLEN,   
    S_AXI_ARSIZE,  
    S_AXI_ARBURST, 
    S_AXI_ARLOCK,  
    S_AXI_ARCACHE, 
    S_AXI_ARPROT,  
    S_AXI_RID,
    S_AXI_RLAST    
  );
  output [7:0] LED_OUT;    
  input [7:0] SW_IN;       
  input [4:0] BTN_IN;      
  input S_AXI_ACLK;        
  input S_AXI_ARESETN;     
  input [31:0] S_AXI_AWADDR;  
  input S_AXI_AWVALID;     
  input [31:0] S_AXI_WDATA;    
  input [3:0] S_AXI_WSTRB;     
  input S_AXI_WVALID;      
  input S_AXI_BREADY;      
  input [31:0] S_AXI_ARADDR;   
  input S_AXI_ARVALID;     
  input S_AXI_RREADY;      
  output S_AXI_ARREADY;    
  output [31:0] S_AXI_RDATA;   
  output [1:0] S_AXI_RRESP;    
  output S_AXI_RVALID;     
  output S_AXI_WREADY;     
  output [1:0] S_AXI_BRESP;    
  output S_AXI_BVALID;     
  output S_AXI_AWREADY;    
  input [11:0] S_AXI_AWID;     
  input [7:0] S_AXI_AWLEN;     
  input [2:0] S_AXI_AWSIZE;    
  input [1:0] S_AXI_AWBURST;   
  input S_AXI_AWLOCK;      
  input [3:0] S_AXI_AWCACHE;   
  input [2:0] S_AXI_AWPROT;    
  input S_AXI_WLAST;       
  output [11:0] S_AXI_BID;     
  input [11:0] S_AXI_ARID;     
  input [7:0] S_AXI_ARLEN;     
  input [2:0] S_AXI_ARSIZE;    
  input [1:0] S_AXI_ARBURST;   
  input S_AXI_ARLOCK;      
  input [3:0] S_AXI_ARCACHE;   
  input [2:0] S_AXI_ARPROT;    
  output [11:0] S_AXI_RID;     
  output S_AXI_RLAST;      
endmodule