module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(
    IPCORE_CLK,       
    IPCORE_RESETN,    
    AXI4_Lite_ACLK,       
    AXI4_Lite_ARESETN,    
    AXI4_Lite_AWADDR,     
    AXI4_Lite_AWVALID,    
    AXI4_Lite_WDATA,      
    AXI4_Lite_WSTRB,      
    AXI4_Lite_WVALID,     
    AXI4_Lite_BREADY,     
    AXI4_Lite_ARADDR,     
    AXI4_Lite_ARVALID,    
    AXI4_Lite_RREADY,     
    AXI4_Lite_AWREADY,    
    AXI4_Lite_WREADY,     
    AXI4_Lite_BRESP,      
    AXI4_Lite_BVALID,     
    AXI4_Lite_ARREADY,    
    AXI4_Lite_RDATA,      
    AXI4_Lite_RRESP,      
    AXI4_Lite_RVALID      
);
input IPCORE_CLK;
input IPCORE_RESETN;
input AXI4_Lite_ACLK;
input AXI4_Lite_ARESETN;
input [15:0] AXI4_Lite_AWADDR;
input AXI4_Lite_AWVALID;
input [31:0] AXI4_Lite_WDATA;
input [3:0] AXI4_Lite_WSTRB;
input AXI4_Lite_WVALID;
input AXI4_Lite_BREADY;
input [15:0] AXI4_Lite_ARADDR;
input AXI4_Lite_ARVALID;
input AXI4_Lite_RREADY;
output AXI4_Lite_AWREADY;
output AXI4_Lite_WREADY;
output [1:0] AXI4_Lite_BRESP;
output AXI4_Lite_BVALID;
output AXI4_Lite_ARREADY;
output [31:0] AXI4_Lite_RDATA;
output [1:0] AXI4_Lite_RRESP;
output AXI4_Lite_RVALID;
endmodule 