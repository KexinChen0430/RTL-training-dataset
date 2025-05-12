module ram_128x8_dp_be ( 
	address_a, 
	address_b, 
	byteena_a, 
	clock_a, 
	clock_b, 
	data_a, 
	data_b, 
	wren_a, 
	wren_b, 
	q_a, 
	q_b); 
input	[2:0]  address_a; 
input	[2:0]  address_b; 
input	[15:0]  byteena_a; 
input	  clock_a; 
input	  clock_b; 
input	[127:0]  data_a; 
input	[127:0]  data_b; 
input	  wren_a; 
input	  wren_b; 
output	[127:0]  q_a; 
output	[127:0]  q_b; 
endmodule 