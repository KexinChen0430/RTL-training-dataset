module system_auto_us_1(
  s_axi_aclk, s_axi_aresetn, s_axi_araddr, s_axi_arlen, s_axi_arsize, s_axi_arburst,
  s_axi_arlock, s_axi_arcache, s_axi_arprot, s_axi_arregion, s_axi_arqos, s_axi_arvalid,
  s_axi_arready, s_axi_rdata, s_axi_rresp, s_axi_rlast, s_axi_rvalid, s_axi_rready,
  m_axi_araddr, m_axi_arlen, m_axi_arsize, m_axi_arburst, m_axi_arlock, m_axi_arcache,
  m_axi_arprot, m_axi_arregion, m_axi_arqos, m_axi_arvalid, m_axi_arready, m_axi_rdata,
  m_axi_rresp, m_axi_rlast, m_axi_rvalid, m_axi_rready
);
  input s_axi_aclk;          
  input s_axi_aresetn;       
  input [31:0] s_axi_araddr; 
  input [7:0] s_axi_arlen;   
  input [2:0] s_axi_arsize;  
  input [1:0] s_axi_arburst; 
  input [0:0] s_axi_arlock;  
  input [3:0] s_axi_arcache; 
  input [2:0] s_axi_arprot;  
  input [3:0] s_axi_arregion;
  input [3:0] s_axi_arqos;   
  input s_axi_arvalid;       
  output s_axi_arready;      
  output [31:0] s_axi_rdata; 
  output [1:0] s_axi_rresp;  
  output s_axi_rlast;        
  output s_axi_rvalid;       
  input s_axi_rready;        
  output [31:0] m_axi_araddr; 
  output [7:0] m_axi_arlen;   
  output [2:0] m_axi_arsize;  
  output [1:0] m_axi_arburst; 
  output [0:0] m_axi_arlock;  
  output [3:0] m_axi_arcache; 
  output [2:0] m_axi_arprot;  
  output [3:0] m_axi_arregion;
  output [3:0] m_axi_arqos;   
  output m_axi_arvalid;       
  input m_axi_arready;        
  input [63:0] m_axi_rdata;   
  input [1:0] m_axi_rresp;    
  input m_axi_rlast;          
  input m_axi_rvalid;         
  output m_axi_rready;        
endmodule