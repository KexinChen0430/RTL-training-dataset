module FIFO_ADC ( 
	clock, 
	data, 
	rdreq, 
	sclr, 
	wrreq, 
	empty, 
	full, 
	q); 
input	  clock; 
input	[15:0]  data; 
input	  rdreq; 
input	  sclr; 
input	  wrreq; 
output	  empty; 
output	  full; 
output	[15:0]  q; 
endmodule 