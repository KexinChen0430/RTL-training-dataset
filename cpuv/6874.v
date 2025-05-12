module RAM512x16_2RW (
	address_a,    
	address_b,    
	byteena_a,    
	byteena_b,    
	clock,        
	data_a,       
	data_b,       
	wren_a,       
	wren_b,       
	q_a,          
	q_b);         
input	[8:0]  address_a;
input	[8:0]  address_b;
input	[1:0]  byteena_a;
input	[1:0]  byteena_b;
input	  clock;
input	[15:0]  data_a;
input	[15:0]  data_b;
input	  wren_a;
input	  wren_b;
output	[15:0]  q_a;
output	[15:0]  q_b;
`ifndef ALTERA_RESERVED_QIS
`endif
tri1	[1:0]  byteena_a;
tri1	[1:0]  byteena_b;
tri1	  clock;
tri0	  wren_a;
tri0	  wren_b;
`ifndef ALTERA_RESERVED_QIS
`endif
endmodule