module sram (
	clock,       
	data,        
	rdaddress,   
	rden,        
	wraddress,   
	wren,        
	q);          
	input	  clock;       
	input	[71:0]  data;       
	input	[9:0]  rdaddress;  
	input	  rden;        
	input	[9:0]  wraddress;  
	input	  wren;        
	output	[71:0]  q;         
	`ifndef ALTERA_RESERVED_QIS
	`endif
	tri1	  clock;       
	tri1	  rden;        
	tri0	  wren;        
	`ifndef ALTERA_RESERVED_QIS
	`endif
endmodule