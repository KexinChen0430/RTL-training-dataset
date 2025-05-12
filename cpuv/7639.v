module RAMB16_S4_altera ( 
	aclr, 
	address, 
	clken, 
	clock, 
	data, 
	wren, 
	q); 
input	  aclr; 
input	[11:0]  address; 
input	  clken; 
input	  clock; 
input	[3:0]  data; 
input	  wren; 
output	[3:0]  q; 
`ifndef ALTERA_RESERVED_QIS 
`endif
	tri0	  aclr; 
	tri1	  clken; 
	tri1	  clock; 
`ifndef ALTERA_RESERVED_QIS 
`endif
endmodule 