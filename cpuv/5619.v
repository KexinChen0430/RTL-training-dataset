module counter_bus_mux (
	data0x,
	data1x,
	sel,
	result);
	input	[3:0]  data0x;
	input	[3:0]  data1x;
	input	  sel;
	output	[3:0]  result;
endmodule