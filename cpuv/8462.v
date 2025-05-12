module GTPE2_COMMON_VPR (
  output DRPRDY,               
  output PLL0FBCLKLOST,        
  output PLL0LOCK,             
  output PLL0OUTCLK,           
  output PLL0OUTREFCLK,        
  output PLL0REFCLKLOST,       
  output PLL1FBCLKLOST,        
  output PLL1LOCK,             
  output PLL1OUTCLK,           
  output PLL1OUTREFCLK,        
  output PLL1REFCLKLOST,       
  output REFCLKOUTMONITOR0,    
  output REFCLKOUTMONITOR1,    
  output [15:0] DRPDO,         
  output [15:0] PMARSVDOUT,    
  output [7:0] DMONITOROUT,    
  input BGBYPASSB,             
  input BGMONITORENB,          
  input BGPDB,                 
  input BGRCALOVRDENB,         
  input DRPCLK,                
  input DRPEN,                 
  input DRPWE,                 
  input GTREFCLK0,             
  input GTREFCLK1,             
  input GTGREFCLK0,            
  input GTGREFCLK1,            
  input PLL0LOCKDETCLK,        
  input PLL0LOCKEN,            
  input PLL0PD,                
  input PLL0RESET,             
  input PLL1LOCKDETCLK,        
  input PLL1LOCKEN,            
  input PLL1PD,                
  input PLL1RESET,             
  input RCALENB,               
  input [15:0] DRPDI,          
  input [2:0] PLL0REFCLKSEL,   
  input [2:0] PLL1REFCLKSEL,   
  input [4:0] BGRCALOVRD,      
  input [7:0] DRPADDR,         
  input [7:0] PMARSVD          
);
  parameter [63:0] BIAS_CFG = 64'h0000000000000000; 
  parameter [31:0] COMMON_CFG = 32'h00000000;       
  parameter [26:0] PLL0_CFG = 27'h01F03DC;          
  parameter [0:0] PLL0_DMON_CFG = 1'b0;             
  parameter [5:0] PLL0_FBDIV = 6'b000010;           
  parameter PLL0_FBDIV_45 = 1'b1;                   
  parameter [23:0] PLL0_INIT_CFG = 24'h00001E;      
  parameter [8:0] PLL0_LOCK_CFG = 9'h1E8;           
  parameter [4:0] PLL0_REFCLK_DIV = 5'b10000;       
  parameter [26:0] PLL1_CFG = 27'h01F03DC;          
  parameter [0:0] PLL1_DMON_CFG = 1'b0;             
  parameter [5:0] PLL1_FBDIV = 6'b000010;           
  parameter PLL1_FBDIV_45 = 1'b1;                   
  parameter [23:0] PLL1_INIT_CFG = 24'h00001E;      
  parameter [8:0] PLL1_LOCK_CFG = 9'h1E8;           
  parameter [4:0] PLL1_REFCLK_DIV = 5'b10000;       
  parameter [7:0] PLL_CLKOUT_CFG = 8'b00000000;     
  parameter [15:0] RSVD_ATTR0 = 16'h0000;           
  parameter [15:0] RSVD_ATTR1 = 16'h0000;           
  parameter INV_DRPCLK = 1'b0;                      
  parameter INV_PLL1LOCKDETCLK = 1'b0;              
  parameter INV_PLL0LOCKDETCLK = 1'b0;              
  parameter GTREFCLK0_USED = 1'b0;                  
  parameter GTREFCLK1_USED = 1'b0;                  
  parameter BOTH_GTREFCLK_USED = 1'b0;              
  parameter ENABLE_DRP = 1'b1;                      
  parameter [1:0] IBUFDS_GTE2_CLKSWING_CFG = 2'b11; 
endmodule