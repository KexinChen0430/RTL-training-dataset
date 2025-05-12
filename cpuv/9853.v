module pci2net_dma_16x32 (  
	aclr,                  
	clock,                 
	data,                  
	rdreq,                 
	wrreq,                 
	almost_full,           
	empty,                 
	full,                  
	q,                     
	usedw);                
input	  aclr;             
input	  clock;            
input	[31:0]  data;      
input	  rdreq;            
input	  wrreq;            
output	  almost_full;      
output	  empty;            
output	  full;             
output	[31:0]  q;         
output	[3:0]  usedw;      
endmodule                 