module tri_state_detect (
	input clk, 
	input rst, 
	input in, 
	output [31:0] count_h, 
	output [31:0] count_l, 
	output detected 
);