module playback_fifo ( 
	aclr, 
	data, 
	rdclk, 
	rdreq, 
	wrclk, 
	wrreq, 
	q, 
	rdempty, 
	rdfull, 
	wrempty, 
	wrfull, 
	wrusedw); 
input	  aclr; 
input	[31:0]  data; 
input	  rdclk; 
input	  rdreq; 
input	  wrclk; 
input	  wrreq; 
output	[63:0]  q; 
output	  rdempty; 
output	  rdfull; 
output	  wrempty; 
output	  wrfull; 
output	[4:0]  wrusedw; 
`ifndef ALTERA_RESERVED_QIS 
`endif
	tri0	  aclr; 
`ifndef ALTERA_RESERVED_QIS 
`endif
endmodule 