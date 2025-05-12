module SB_DFFSR (output Q, input C, R, D); 
`SB_DFF_REG 
always @(posedge C) 
	if (R) 
		Q <= 0; 
	else 
		Q <= D; 
endmodule 