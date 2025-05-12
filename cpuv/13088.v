module next_state_logic(S3,S2,S1,S0,Xp,Yp,Zp,Xn,Yn,Zn); 
	input S3,S2,S1,S0; 
	output Xn,Yn,Zn; 
	reg Xn,Yn,Zn; 
	always@(S3 or S2 or S1 or S0) 
	begin
		casex({S3,S2,S1,S0}) 
			4'b0000: F= 3'b000; 
			4'b0001: F= 3'b001; 
			4'b0010: F= 3'b010; 
			4'b0011: F= 3'b011; 
			4'b0100: F= 3'b100; 
			4'b0101: F= 3'b101; 
			4'b0110: F= 3'b110; 
			4'b0111: F= 3'b111; 
			4'b01xx: F= 3'b000; 
			default: F= 3'b000; 
		endcase
	end
endmodule