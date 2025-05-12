module  sin_altfp_sincos_cordic_atan_55b
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
	wire  [47:0]  valuenode_1_w;
	wire  [47:0]  valuenode_3_w;
	assign
		arctan = (({34{(~ indexbit)}} & valuenode_1_w[47:14]) | ({34{indexbit}} & valuenode_3_w[45:12])),
		valuenode_1_w = 48'b000111011010110001100111000001010110000110111011,
		valuenode_3_w = 48'b000001111111010101101110101001101010101100001100;
endmodule