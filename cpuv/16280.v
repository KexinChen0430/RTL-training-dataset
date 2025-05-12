module altera_tse_alt4gxb_gige (
	cal_blk_clk,                
	fixedclk,                   
	fixedclk_fast,              
	gxb_powerdown,              
	pll_inclk,                  
	reconfig_clk,               
	reconfig_togxb,             
	rx_analogreset,             
	rx_cruclk,                  
	rx_datain,                  
	rx_digitalreset,            
	rx_seriallpbken,            
	tx_ctrlenable,              
	tx_datain,                  
	tx_digitalreset,            
	reconfig_fromgxb,           
	rx_clkout,                  
	rx_ctrldetect,              
	rx_dataout,                 
	rx_disperr,                 
	rx_errdetect,               
	rx_patterndetect,           
	rx_rlv,                     
	rx_rmfifodatadeleted,       
	rx_rmfifodatainserted,      
	rx_runningdisp,             
	rx_syncstatus,              
	tx_clkout,                  
	tx_dataout                  
); 
	input	  cal_blk_clk;       
	input	  fixedclk;          
	input	[5:0]  fixedclk_fast; 
	input	[0:0]  gxb_powerdown; 
	input	  pll_inclk;         
	input	  reconfig_clk;      
	input	[3:0]  reconfig_togxb; 
	input	[0:0]  rx_analogreset; 
	input	[0:0]  rx_cruclk;     
	input	[0:0]  rx_datain;     
	input	[0:0]  rx_digitalreset; 
	input	[0:0]  rx_seriallpbken; 
	input	[0:0]  tx_ctrlenable; 
	input	[7:0]  tx_datain;     
	input	[0:0]  tx_digitalreset; 
	output	[16:0]  reconfig_fromgxb; 
	output	  rx_clkout;         
	output	[0:0]  rx_ctrldetect; 
	output	[7:0]  rx_dataout;    
	output	[0:0]  rx_disperr;    
	output	[0:0]  rx_errdetect;  
	output	[0:0]  rx_patterndetect; 
	output	[0:0]  rx_rlv;        
	output	[0:0]  rx_rmfifodatadeleted; 
	output	[0:0]  rx_rmfifodatainserted; 
	output	[0:0]  rx_runningdisp; 
	output	[0:0]  rx_syncstatus; 
	output	[0:0]  tx_clkout;     
	output	[0:0]  tx_dataout;    
`ifndef ALTERA_RESERVED_QIS
`endif
	tri0	[0:0]  rx_cruclk;     
`ifndef ALTERA_RESERVED_QIS
`endif
	parameter		starting_channel_number = 0; 
endmodule