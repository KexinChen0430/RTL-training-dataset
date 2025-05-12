module RAMB16_S9_altera (
	address, 
	clock,   
	data,    
	rden,    
	wren,    
	q);      
	input	[10:0]  address; 
	input	  clock;       
	input	[7:0]  data;    
	input	  rden;        
	input	  wren;        
	output	[7:0]  q;      
endmodule