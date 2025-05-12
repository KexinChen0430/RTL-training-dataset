module fifo ( 
	clock, 
	data, 
	rdreq, 
	wrreq, 
	empty, 
	q); 
input	  clock; 
input	[7:0]  data; 
input	  rdreq; 
input	  wrreq; 
output	  empty; 
output	[7:0]  q; 
endmodule 