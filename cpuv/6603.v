module fifo_32x128 ( 
	data, 
	wrreq, 
	rdreq, 
	clock, 
	aclr, 
	q, 
	full, 
	empty, 
	usedw); 
input	[31:0]  data; 
input	  wrreq; 
input	  rdreq; 
input	  clock; 
input	  aclr; 
output	[31:0]  q; 
output	  full; 
output	  empty; 
output	[6:0]  usedw; 
endmodule 