module SB_DFFNER (output reg Q, input C, E, R, D); 
	`SB_DFF_REG
	always @(negedge C, posedge R)
		if (R) 
			Q <= 0; 
		else if (E) 
			Q <= D; 
endmodule 