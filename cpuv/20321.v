module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(
  LEDs_out,
  s00_axi_awaddr,   
  s00_axi_awprot,   
  s00_axi_awvalid,  
  s00_axi_awready,  
  s00_axi_wdata,    
  s00_axi_wstrb,    
  s00_axi_wvalid,   
  s00_axi_wready,   
  s00_axi_bresp,    
  s00_axi_bvalid,   
  s00_axi_bready,   
  s00_axi_araddr,   
  s00_axi_arprot,   
  s00_axi_arvalid,  
  s00_axi_arready,  
  s00_axi_rdata,    
  s00_axi_rresp,    
  s00_axi_rvalid,   
  s00_axi_rready,   
  s00_axi_aclk,     
  s00_axi_aresetn   
);
output [7:0] LEDs_out;
input [3:0] s00_axi_awaddr;
input [2:0] s00_axi_awprot;
input s00_axi_awvalid;
output s00_axi_awready;
input [31:0] s00_axi_wdata;
input [3:0] s00_axi_wstrb;
input s00_axi_wvalid;
output s00_axi_wready;
output [1:0] s00_axi_bresp;
output s00_axi_bvalid;
input s00_axi_bready;
input [3:0] s00_axi_araddr;
input [2:0] s00_axi_arprot;
input s00_axi_arvalid;
output s00_axi_arready;
output [31:0] s00_axi_rdata;
output [1:0] s00_axi_rresp;
output s00_axi_rvalid;
input s00_axi_rready;
input s00_axi_aclk;
input s00_axi_aresetn;
endmodule 