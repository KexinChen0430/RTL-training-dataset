module  sin_altfp_sincos_cordic_atan_85b
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
	wire  [47:0]  valuenode_4_w; 
	wire  [47:0]  valuenode_6_w; 
	assign
		arctan = (({34{(~ indexbit)}} & valuenode_4_w[47:14]) | ({34{indexbit}} & valuenode_6_w[45:12])),
		valuenode_4_w = 48'b000000111111111010101011011101101110010110100000,
		valuenode_6_w = 48'b000000001111111111111010101010101101110111011100;
endmodule