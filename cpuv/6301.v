module nes_zybo_wrapper_X99(a,o); 
	input[5:0]  a; 
	output reg[7:0]  o; 
	always @(a) 
	begin
		case(a) 
			6'b000000: o = 8'b01101101; 
			6'b000001: o = 8'b00100010; 
			6'b111111: o = 8'b00000000; 
		endcase 
	end 
endmodule 