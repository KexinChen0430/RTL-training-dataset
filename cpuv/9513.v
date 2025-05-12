module async_fifo_256x72_to_36 ( 
	aclr, 
	data, 
	rdclk, 
	rdreq, 
	wrclk, 
	wrreq, 
	q, 
	rdempty, 
	rdusedw, 
	wrfull); 
input	  aclr; 
input	[71:0]  data; 
input	  rdclk; 
input	  rdreq; 
input	  wrclk; 
input	  wrreq; 
output	[35:0]  q; 
output	  rdempty; 
output	[8:0]  rdusedw; 
output	  wrfull; 
`ifndef ALTERA_RESERVED_QIS 
`endif
	tri0	  aclr; 
`ifndef ALTERA_RESERVED_QIS 
`endif
endmodule 