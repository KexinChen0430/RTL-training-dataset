module RAMB16_S4_2_altera (  
	clock,                   
	data,                    
	rdaddress,               
	wraddress,               
	wren,                    
	q);                      
	input	  clock;          
	input	[3:0]  data;     
	input	[11:0]  rdaddress; 
	input	[11:0]  wraddress; 
	input	  wren;           
	output	[3:0]  q;        
`ifndef ALTERA_RESERVED_QIS  
`endif
	tri1	  clock;          
	tri0	  wren;           
`ifndef ALTERA_RESERVED_QIS  
`endif
endmodule                    