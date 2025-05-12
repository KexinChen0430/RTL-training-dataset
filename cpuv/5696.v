module SB_DFFNE (output Q, input C, E, D);
	`SB_DFF_REG
	always @(negedge C)
		if (E)
			Q <= D;
endmodule