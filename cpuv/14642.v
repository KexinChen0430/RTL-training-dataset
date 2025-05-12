module lpm_ram_dq1 ( 
	address, 
	clock, 
	data, 
	wren, 
	q); 
	input	[4:0]  address; 
	input	  clock; 
	input	[7:0]  data; 
	input	  wren; 
	output	[7:0]  q; 
endmodule 