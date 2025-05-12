module sfifo_112x256_la ( 
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
input	[111:0]  data; 
input	  rdreq; 
input	  wrreq; 
output	  almost_full; 
output	  empty; 
output	  full; 
output	[111:0]  q; 
output	[7:0]  usedw; 
endmodule 