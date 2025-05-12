module cm_rom_shared (  
	address_a,         
	address_b,
	clock,
	q_a,
	q_b);             
	input	[8:0]  address_a;  
	input	[8:0]  address_b;  
	input	  clock;          
	output	[3:0]  q_a;       
	output	[3:0]  q_b;       
`ifndef ALTERA_RESERVED_QIS  
`endif
	tri1	  clock;          
`ifndef ALTERA_RESERVED_QIS  
`endif
endmodule  