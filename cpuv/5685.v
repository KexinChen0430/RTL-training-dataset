module SB_DFFNESR (output Q, input C, E, R, D); 
`SB_DFF_REG 
always @(negedge C) 
	if (E) begin 
		if (R) 
			Q <= 0; 
		else 
			Q <= D; 
	end 
endmodule 