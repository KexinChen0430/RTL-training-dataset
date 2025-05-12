module asyn_256_139 (
	aclr,     
	data,     
	rdclk,    
	rdreq,    
	wrclk,    
	wrreq,    
	q,        
	wrusedw   
);
	input	  aclr;       
	input	[138:0]  data; 
	input	  rdclk;      
	input	  rdreq;      
	input	  wrclk;      
	input	  wrreq;      
	output	[138:0]  q;   
	output	[7:0]  wrusedw; 
`ifndef ALTERA_RESERVED_QIS
`endif
	tri0	  aclr;
`ifndef ALTERA_RESERVED_QIS
`endif
endmodule