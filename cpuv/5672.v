module SB_DFFS (output Q, input C, S, D); 
`SB_DFF_REG 
always @(posedge C, posedge S) 
	if (S) 
		Q <= 1; 
	else 
		Q <= D; 
endmodule 