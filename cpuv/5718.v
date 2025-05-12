module SB_DFFN (output Q, input C, D); 
	`SB_DFF_REG 
	always @(negedge C) 
		Q <= D; 
endmodule 