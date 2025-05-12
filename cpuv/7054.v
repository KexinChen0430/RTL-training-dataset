module rom_shared ( 
	aclr, 
	address_a, 
	address_b, 
	clock, 
	rden_a, 
	rden_b, 
	q_a, 
	q_b); 
	input	  aclr; 
	input	[11:0]  address_a; 
	input	[11:0]  address_b; 
	input	  clock; 
	input	  rden_a; 
	input	  rden_b; 
	output	[31:0]  q_a; 
	output	[31:0]  q_b; 
`ifndef ALTERA_RESERVED_QIS 
`endif
	tri0	  aclr; 
	tri1	  clock; 
	tri1	  rden_a; 
	tri1	  rden_b; 
`ifndef ALTERA_RESERVED_QIS 
`endif
endmodule 