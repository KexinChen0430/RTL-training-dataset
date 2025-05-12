module mult88 ( 
	clock0, 
	dataa_0, 
	dataa_1, 
	datab_0, 
	datab_1, 
	result); 
	input	  clock0; 
	input	[7:0]  dataa_0; 
	input	[7:0]  dataa_1; 
	input	[8:0]  datab_0; 
	input	[8:0]  datab_1; 
	output	[17:0]  result; 
`ifndef ALTERA_RESERVED_QIS 
`endif
	tri1	  clock0; 
	tri0	[7:0]  dataa_0; 
	tri0	[7:0]  dataa_1; 
	tri0	[8:0]  datab_0; 
	tri0	[8:0]  datab_1; 
`ifndef ALTERA_RESERVED_QIS 
`endif
endmodule 