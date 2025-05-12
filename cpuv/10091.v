module rambuffer ( 
	address_a, 
	address_b, 
	clock, 
	data_a, 
	data_b, 
	wren_a, 
	wren_b, 
	q_a, 
	q_b); 
input	[16:0]  address_a; 
input	[16:0]  address_b; 
input	  clock; 
input	[0:0]  data_a; 
input	[0:0]  data_b; 
input	  wren_a; 
input	  wren_b; 
output	[0:0]  q_a; 
output	[0:0]  q_b; 
`ifndef ALTERA_RESERVED_QIS 
`endif
	tri1	  clock; 
	tri0	  wren_a; 
	tri0	  wren_b; 
`ifndef ALTERA_RESERVED_QIS 
`endif
endmodule 