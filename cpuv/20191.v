module axi_interconnect #(
  parameter ADDR_WIDTH = 32, 
  parameter DATA_WIDTH = 32  
)(
  input clk,                  
  input rst,                  
  output [3:0] i_awid,        
  output [ADDR_WIDTH - 1:0] i_awaddr, 
  output [3:0] i_awlen,       
  output [2:0] i_awsize,      
  output [1:0] i_awburst,     
  output [1:0] i_awlock,      
  output [3:0] i_awcache,     
  output [2:0] i_awprot,      
  output i_awvalid,           
  input o_awready,            
  output reg [3:0] i_wid,     
  output reg [DATA_WIDTH - 1: 0] i_wdata, 
  output reg [DATA_WIDTH >> 3:0] i_wstrobe, 
  output reg i_wlast,         
  output reg i_wvalid,        
  input o_wready,             
  input [3:0] o_bid,          
  input [1:0] o_bresp,        
  input o_bvalid,             
  output reg i_bready,        
  output reg [3:0] i_arid,    
  output [ADDR_WIDTH - 1:0] i_araddr, 
  output reg [3:0] i_arlen,   
  output reg [2:0] i_arsize,  
  output [1:0] i_arburst,     
  output [1:0] i_arlock,      
  output [3:0] i_arcache,     
  output [2:0] i_arprot,      
  output reg i_arvalid,       
  input o_arready,            
  input [3:0] o_rid,          
  input [DATA_WIDTH - 1: 0] o_rdata, 
  input [DATA_WIDTH >> 3:0] o_rstrobe, 
  input o_rlast,              
  input o_rvalid,             
  output reg i_rready,        
  ${PORTS}
  ${ADDRESSES}
  localparam ADDR_NO_SEL = ((1 << ADDR_WIDTH) - 1); 
  wire [3:0] slave_select;
  assign slave_select = i_m_adr[31:24];
  ${DATA}
  ${ACK}
  ${ASSIGN}
endmodule