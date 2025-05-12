module ram_32_128x8_dp_be ( 
	address_a, 
	address_b, 
	byteena_b, 
	clock_a, 
	clock_b, 
	data_a, 
	data_b, 
	wren_a, 
	wren_b, 
	q_a, 
	q_b); 
input	[2:0]  address_a; 
input	[4:0]  address_b; 
input	[3:0]  byteena_b; 
input	  clock_a; 
input	  clock_b; 
input	[127:0]  data_a; 
input	[31:0]  data_b; 
input	  wren_a; 
input	  wren_b; 
output	[127:0]  q_a; 
output	[31:0]  q_b; 
endmodule 