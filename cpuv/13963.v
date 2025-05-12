module esaxilite (
   s_axicfg_arready, s_axicfg_awready, s_axicfg_bresp,
   s_axicfg_bvalid, s_axicfg_rdata, s_axicfg_rresp, s_axicfg_rvalid,
   s_axicfg_wready, mi_clk, mi_en, mi_we, mi_addr, mi_din,
   s_axicfg_araddr, s_axicfg_arprot, s_axicfg_arvalid,
   s_axicfg_awaddr, s_axicfg_awprot, s_axicfg_awvalid,
   s_axicfg_bready, s_axicfg_rready, s_axicfg_wdata, s_axicfg_wstrb,
   s_axicfg_wvalid, mi_rd_data
   );
   parameter RFAW      = 16;
   input [15:0]  s_axicfg_araddr;   
   input [2:0]   s_axicfg_arprot;   
   output        s_axicfg_arready;  
   input         s_axicfg_arvalid;  
   input [15:0]  s_axicfg_awaddr;   
   input [2:0]   s_axicfg_awprot;   
   output        s_axicfg_awready;  
   input         s_axicfg_awvalid;  
   input         s_axicfg_bready;   
   output [1:0]  s_axicfg_bresp;    
   output        s_axicfg_bvalid;   
   output [31:0] s_axicfg_rdata;    
   input         s_axicfg_rready;   
   output [1:0]  s_axicfg_rresp;    
   output        s_axicfg_rvalid;   
   input [31:0]  s_axicfg_wdata;    
   output        s_axicfg_wready;   
   input [3:0]   s_axicfg_wstrb;    
   input         s_axicfg_wvalid;   
   output        mi_clk;            
   output        mi_en;             
   output        mi_we;             
   output [RFAW-1:0] mi_addr;       
   output [31:0] mi_din;            
   input [31:0]  mi_rd_data;        
endmodule