module SB_DFFER (output Q, input C, E, R, D); 
`SB_DFF_REG 
always @(posedge C, posedge R) 
	if (R) 
		Q <= 0; 
	else if (E) 
		Q <= D; 
endmodule 