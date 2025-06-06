module RAMB16_S9_altera (
	address, 
	clock,
	data,
	rden,
	wren,
	q);
	input	[10:0]  address; 
	input	  clock;        
	input	[7:0]  data;    
	input	  rden;         
	input	  wren;         
	output	[7:0]  q;       
`ifndef ALTERA_RESERVED_QIS
`endif
	tri1	  clock;        
	tri1	  rden;         
`ifndef ALTERA_RESERVED_QIS
`endif
endmodule 