module SB_DFFNES (output Q, input C, E, S, D);
	`SB_DFF_REG
	always @(negedge C, posedge S)
		if (S)
			Q <= 1;
		else if (E)
			Q <= D;
endmodule