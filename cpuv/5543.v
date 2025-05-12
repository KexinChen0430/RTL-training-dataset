module async_fifo_512x36_to_72_progfull_500 ( 
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
input	[35:0]  data; 
input	  rdclk; 
input	  rdreq; 
input	  wrclk; 
input	  wrreq; 
output	[71:0]  q; 
output	  rdempty; 
output	  wrfull; 
output	[8:0]  wrusedw; 
`ifndef ALTERA_RESERVED_QIS 
`endif
	tri0	  aclr; 
`ifndef ALTERA_RESERVED_QIS 
`endif
endmodule 