module uart_fifo_dual_port_ram (
	clock,      
	data,       
	rdaddress,  
	wraddress,  
	wren,       
	q);         
	input	  clock;      
	input	[7:0]  data;      
	input	[9:0]  rdaddress; 
	input	[9:0]  wraddress; 
	input	  wren;        
	output	[7:0]  q;        
`ifndef ALTERA_RESERVED_QIS
`endif
	tri1	  clock;      
	tri0	  wren;       
`ifndef ALTERA_RESERVED_QIS
`endif
endmodule