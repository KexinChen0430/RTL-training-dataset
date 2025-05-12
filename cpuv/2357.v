module RAM32Kx8x16(input CLK1, input[14:0] AB1, input CS1,
					 input READ, output[7:0] DO1, input[7:0] DI1,
				    input CLK2, input[13:0] AB2, input CS2, output[15:0] DO2);
	wire[1:0] CSM = {(~AB1[0]) & CS1, AB1[0] & CS1}; 
	wire[13:0] AB1x = AB1[14:1];
`include "fighter.v"
endmodule