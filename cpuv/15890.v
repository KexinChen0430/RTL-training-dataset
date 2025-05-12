module qlal3_ram_512x32_cell (
  input  [ 8:0] RAM_P0_ADDR,       
  input         RAM_P0_CLK,        
  input         RAM_P0_CLKS,       
  input  [ 3:0] RAM_P0_WR_BE,      
  input  [31:0] RAM_P0_WR_DATA,    
  input         RAM_P0_WR_EN,      
  input  [ 8:0] RAM_P1_ADDR,       
  input         RAM_P1_CLK,        
  input         RAM_P1_CLKS,       
  output [31:0] RAM_P1_RD_DATA,    
  input         RAM_P1_RD_EN,      
  input         RAM_RME_af,        
  input  [ 3:0] RAM_RM_af,         
  input         RAM_TEST1_af,      
);
endmodule