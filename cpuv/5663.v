module SB_DFFR (output Q, input C, R, D); 
	`SB_DFF_REG 
	always @(posedge C, posedge R) 
		if (R) 
			Q <= 0; 
		else 
			Q <= D; 
endmodule 