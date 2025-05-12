module wb_ram_32x8192 ( 
	address, 
	byteena, 
	clock,  
	data,   
	wren,   
	q);     
input	[12:0]  address; 
input	[3:0]  byteena; 
input	  clock; 
input	[31:0]  data; 
input	  wren; 
output	[31:0]  q; 
`ifndef ALTERA_RESERVED_QIS 
`endif
tri1	[3:0]  byteena; 
tri1	  clock; 
`ifndef ALTERA_RESERVED_QIS 
`endif
endmodule 