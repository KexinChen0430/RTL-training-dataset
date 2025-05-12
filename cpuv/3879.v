module  sin_altfp_sincos_cordic_atan_b5b
	(
	arctan, 
	indexbit) ; 
	output   [33:0]  arctan; 
	input   indexbit; 
`ifndef ALTERA_RESERVED_QIS
`endif
	tri0   indexbit; 
`ifndef ALTERA_RESERVED_QIS
`endif
	wire  [47:0]  valuenode_7_w; 
	wire  [47:0]  valuenode_9_w; 
	assign
		arctan = (({34{(~ indexbit)}} & valuenode_7_w[47:14]) | ({34{indexbit}} & valuenode_9_w[45:12])),
		valuenode_7_w = 48'b000000000111111111111111010101010101011011101111,
		valuenode_9_w = 48'b000000000001111111111111111111010101010101010110;
endmodule