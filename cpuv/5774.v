module SB_DFFSS (output Q, input C, S, D); 
`SB_DFF_REG 
always @(posedge C) 
	if (S) 
		Q <= 1; 
	else 
		Q <= D; 
endmodule 