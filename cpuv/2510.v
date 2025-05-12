module jump_ram (
	address_a, 
	address_b, 
	clock,     
	rden_a,    
	rden_b,    
	q_a,       
	q_b        
);
	input	[4:0]  address_a; 
	input	[4:0]  address_b; 
	input	  clock;         
	input	  rden_a;        
	input	  rden_b;        
	output	[15:0]  q_a;     
	output	[15:0]  q_b;     
	`ifndef ALTERA_RESERVED_QIS
	`endif
	tri1	  clock;   
	tri1	  rden_a;  
	tri1	  rden_b;  
	`ifndef ALTERA_RESERVED_QIS
	`endif
endmodule