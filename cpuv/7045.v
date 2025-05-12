module ip_ram (
	address,
	clock,
	data,
	wren,
	q);
	input	[14:0]  address;
	input	  clock;
	input	[15:0]  data;
	input	  wren;
	output	[15:0]  q;
`ifndef ALTERA_RESERVED_QIS
`endif
	tri1	  clock;
`ifndef ALTERA_RESERVED_QIS
`endif
endmodule