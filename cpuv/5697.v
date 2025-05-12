module SB_DFFNSS (output Q, input C, S, D);
	`SB_DFF_REG
	always @(negedge C)
		if (S)
			Q <= 1;
		else
			Q <= D;
endmodule