module RAM16_s36_s36_altera (
	address_a, 
	address_b, 
	clock_a,   
	clock_b,   
	data_a,    
	data_b,    
	wren_a,    
	wren_b,    
	q_a,       
	q_b        
);
	input	[9:0]  address_a;
	input	[9:0]  address_b;
	input	  clock_a;
	input	  clock_b;
	input	[31:0]  data_a;
	input	[31:0]  data_b;
	input	  wren_a;
	input	  wren_b;
	output	[31:0]  q_a;
	output	[31:0]  q_b;
`ifndef ALTERA_RESERVED_QIS
`endif
	tri1	  clock_a; 
	tri0	  wren_a;  
	tri0	  wren_b;  
`ifndef ALTERA_RESERVED_QIS
`endif
endmodule