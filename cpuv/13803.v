module Grid ( 
	address, 
	clock, 
	q); 
	input	[14:0]  address; 
	input	  clock; 
	output	[2:0]  q; 
`ifndef ALTERA_RESERVED_QIS 
`endif
	tri1	  clock; 
`ifndef ALTERA_RESERVED_QIS 
`endif
endmodule 