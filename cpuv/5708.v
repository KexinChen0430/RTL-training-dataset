module SB_DFFESR (output Q, input C, E, R, D); 
	`SB_DFF_REG 
	always @(posedge C) 
		if (E) begin 
			if (R) 
				Q <= 0; 
			else 
				Q <= D; 
		end 
endmodule 