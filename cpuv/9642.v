module DPRAM ( 
	data, 
	rdaddress, 
	rdclock, 
	wraddress, 
	wrclock, 
	wren, 
	q); 
	input	[11:0]  data; 
	input	[8:0]  rdaddress; 
	input	  rdclock; 
	input	[8:0]  wraddress; 
	input	  wrclock; 
	input	  wren; 
	output	[11:0]  q; 
`ifndef ALTERA_RESERVED_QIS 
`endif
	tri1	  wren; 
`ifndef ALTERA_RESERVED_QIS 
`endif
endmodule 