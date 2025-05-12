module dpram_32_32x16_be ( 
	data, 
	wren, 
	wraddress, 
	rdaddress, 
	byteena_a, 
	wrclock, 
	rdclock, 
	q); 
	input	[31:0]  data; 
	input	  wren; 
	input	[3:0]  wraddress; 
	input	[3:0]  rdaddress; 
	input	[3:0]  byteena_a; 
	input	  wrclock; 
	input	  rdclock; 
	output	[31:0]  q; 
endmodule 