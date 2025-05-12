module FIFO_SUM_IN_SQUARED (
	clock,   
	data,    
	rdreq,   
	sclr,    
	wrreq,   
	empty,   
	full,    
	q        
);
	input	  clock;      
	input	[25:0]  data;      
	input	  rdreq;      
	input	  sclr;       
	input	  wrreq;      
	output	  empty;      
	output	  full;       
	output	[25:0]  q;        
endmodule