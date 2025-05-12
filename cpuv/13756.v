module FONT_ROM(input[10:0] adr, input cs, output[7:0] DO); 
	reg[7:0] mem[0:2047]; 
	assign DO = cs?mem[adr]:8'bZ; 
	initial begin 
		`include "agathe7.v" 
	end 
endmodule 