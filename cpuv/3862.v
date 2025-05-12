module sin_altfp_sincos_cordic_atan_65b
(
	arctan,     
	indexbit    
);
	output   [33:0]  arctan; 
	input   indexbit;        
	`ifndef ALTERA_RESERVED_QIS
	`endif
	tri0   indexbit;
	`ifndef ALTERA_RESERVED_QIS
	`endif
	wire  [47:0]  valuenode_2_w;
	wire  [47:0]  valuenode_4_w;
	assign
		arctan = (({34{(~ indexbit)}} & valuenode_2_w[47:14]) | ({34{indexbit}} & valuenode_4_w[45:12])),
		valuenode_2_w = 48'b000011111010110110111010111111001001011001000000,
		valuenode_4_w = 48'b000000111111111010101011011101101110010110100000;
endmodule