module ROM2kx8(input CLK, input[10:0] AB, input CS, output[7:0] DO); 
	reg[7:0] mem[0:2047]; 
	reg[7:0] R; 
	assign DO = CS? R: 8'bZ; 
	always @(posedge CLK) if (CS) R <= mem[AB]; 
	initial begin
		`include "monitor7.v" 
	end
endmodule 