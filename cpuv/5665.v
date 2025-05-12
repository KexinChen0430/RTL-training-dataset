module SB_DFF (output Q, input C, D);
	`SB_DFF_REG
	always @(posedge C)
		Q <= D;
endmodule