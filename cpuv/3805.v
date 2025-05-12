module  sin_altfp_sincos_cordic_atan_o6b
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
	wire  [47:0]  valuenode_13_w; 
	wire  [47:0]  valuenode_15_w; 
	assign
		arctan = (({34{(~ indexbit)}} & valuenode_13_w[47:14]) | ({34{indexbit}} & valuenode_15_w[45:12])),
		valuenode_13_w = 48'b000000000000000111111111111111111111111111010101,
		valuenode_15_w = 48'b000000000000000001111111111111111111111111111111;
endmodule