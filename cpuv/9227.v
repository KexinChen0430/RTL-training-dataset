module fifo_144x128 ( 
	aclr, 
	clock, 
	data, 
	rdreq, 
	wrreq, 
	empty, 
	full, 
	q, 
	usedw); 
input	  aclr; 
input	  clock; 
input	[143:0]  data; 
input	  rdreq; 
input	  wrreq; 
output	  empty; 
output	  full; 
output	[143:0]  q; 
output	[6:0]  usedw; 
endmodule 