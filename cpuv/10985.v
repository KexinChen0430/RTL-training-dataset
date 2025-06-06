module fifo_128x128a (  
	aclr,              
	data,              
	rdclk,             
	rdreq,             
	wrclk,             
	wrreq,             
	q,                 
	rdempty,           
	wrfull,            
	wrusedw);          
input	  aclr;       
input	[127:0]  data; 
input	  rdclk;      
input	  rdreq;      
input	  wrclk;      
input	  wrreq;      
output	[127:0]  q;   
output	  rdempty;    
output	  wrfull;     
output	[6:0]  wrusedw; 
endmodule             