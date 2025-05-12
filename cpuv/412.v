module FIFO_DETECTION_YN (
	clock,   
	data,    
	rdreq,   
	sclr,    
	wrreq,   
	empty,   
	full,    
	q);      
	input	  clock;       
	input	[109:0]  data; 
	input	  rdreq;       
	input	  sclr;        
	input	  wrreq;       
	output	  empty;       
	output	  full;        
	output	[109:0]  q;   
endmodule