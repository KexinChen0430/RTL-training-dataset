module bigasfuckram ( 
	address, 
	clock, 
	data, 
	wren, 
	q); 
	input	[4:0]  address; 
	input	  clock; 
	input	[26:0]  data; 
	input	  wren; 
	output	[26:0]  q; 
`ifndef ALTERA_RESERVED_QIS 
`endif
	tri1	  clock; 
`ifndef ALTERA_RESERVED_QIS 
`endif
endmodule 