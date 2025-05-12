module SB_DFFNS (output Q, input C, S, D); 
`SB_DFF_REG 
always @(negedge C, posedge S) 
	if (S) 
		Q <= 1; 
	else 
		Q <= D; 
endmodule 