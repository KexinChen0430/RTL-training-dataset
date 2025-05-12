module float_mult (
	clock,      
	dataa,      
	datab,      
	overflow,   
	result      
); 
	input	  clock;       
	input	[31:0]  dataa; 
	input	[31:0]  datab; 
	output	  overflow;    
	output	[31:0]  result; 
endmodule 