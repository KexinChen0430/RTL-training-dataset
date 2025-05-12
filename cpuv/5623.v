module SB_DFFE (output Q, input C, E, D);
	`SB_DFF_REG
	always @(posedge C)
		if (E)
			Q <= D;
endmodule