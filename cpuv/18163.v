module datamux (
	aclr,       
	clock,      
	data0x,     
	data1x,     
	data2x,     
	data3x,     
	sel,        
	result);    
	input	  aclr;
	input	  clock;
	input	[7:0]  data0x;
	input	[7:0]  data1x;
	input	[7:0]  data2x;
	input	[7:0]  data3x;
	input	[1:0]  sel;
	output	[7:0]  result;
`ifndef ALTERA_RESERVED_QIS
`endif
	tri0	  aclr;
`ifndef ALTERA_RESERVED_QIS
`endif
endmodule