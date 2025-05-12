module DE1_SOC_golden_top(
	`ifdef ENABLE_ADC
    output             ADC_CONVST,    
    output             ADC_DIN,       
    input              ADC_DOUT,      
    output             ADC_SCLK,      
	`endif
	`ifdef ENABLE_AUD
    input              AUD_ADCDAT,    
    inout              AUD_ADCLRCK,   
    inout              AUD_BCLK,      
    output             AUD_DACDAT,    
    inout              AUD_DACLRCK,   
    output             AUD_XCK,       
	`endif
	`ifdef ENABLE_CLOCK2
    input              CLOCK2_50,     
	`endif
	`ifdef ENABLE_CLOCK3
    input              CLOCK3_50,     
	`endif
	`ifdef ENABLE_CLOCK4
    input              CLOCK4_50,     
	`endif
	`ifdef ENABLE_CLOCK
    input              CLOCK_50,      
	`endif
	`ifdef ENABLE_DRAM
    output      [12:0] DRAM_ADDR,     
    output      [1:0]  DRAM_BA,       
    output             DRAM_CAS_N,    
    output             DRAM_CKE,      
    output             DRAM_CLK,      
    output             DRAM_CS_N,     
    inout       [15:0] DRAM_DQ,       
    output             DRAM_LDQM,     
    output             DRAM_RAS_N,    
    output             DRAM_UDQM,     
    output             DRAM_WE_N,     
	`endif
	`ifdef ENABLE_FAN
    output             FAN_CTRL,      
	`endif
	`ifdef ENABLE_FPGA
    output             FPGA_I2C_SCLK, 
    inout              FPGA_I2C_SDAT, 
	`endif
	`ifdef ENABLE_GPIO
    inout     [35:0]   GPIO_0,        
    inout     [35:0]   GPIO_1,        
	`endif
	`ifdef ENABLE_HEX
    output      [6:0]  HEX0,          
    output      [6:0]  HEX1,          
    output      [6:0]  HEX2,          
    output      [6:0]  HEX3,          
    output      [6:0]  HEX4,          
    output      [6:0]  HEX5,          
	`endif
	`ifdef ENABLE_HPS
`endif
	`ifdef ENABLE_IRDA
    input              IRDA_RXD,      
    output             IRDA_TXD,      
	`endif
	`ifdef ENABLE_KEY
    input       [3:0]  KEY,           
	`endif
	`ifdef ENABLE_LEDR
    output      [9:0]  LEDR,          
	`endif
	`ifdef ENABLE_PS2
    inout              PS2_CLK,       
    inout              PS2_CLK2,      
    inout              PS2_DAT,       
    inout              PS2_DAT2,      
	`endif
	`ifdef ENABLE_SW
    input       [9:0]  SW,            
	`endif
	`ifdef ENABLE_TD
    input             TD_CLK27,       
    input      [7:0]  TD_DATA,        
    input             TD_HS,          
    output            TD_RESET_N,     
    input             TD_VS,          
	`endif
	`ifdef ENABLE_VGA
    output      [7:0]  VGA_B,         
    output             VGA_BLANK_N,   
    output             VGA_CLK,       
    output      [7:0]  VGA_G,         
    output             VGA_HS,        
    output      [7:0]  VGA_R,         
    output             VGA_SYNC_N,    
    output             VGA_VS         
	`endif
);
endmodule 