module divider (
	clock,      
	denom,      
	numer,      
	quotient,   
	remain);    
	input	  clock;    
	input	[4:0]  denom;   
	input	[10:0]  numer;  
	output	[10:0]  quotient; 
	output	[4:0]  remain;    
endmodule