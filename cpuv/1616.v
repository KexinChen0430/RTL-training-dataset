module bcd_to_display(
	input clk, 
	input rst, 
	input [3:0] BCD, 
	output reg[7:0] DISPLAY 
	);