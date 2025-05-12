module trigger_in_async
(
	input clk80, 
	input clk400, 
	input sync, 
	input reset, 
	input trigger_in, 
	output [4:0]trigger_out, 
	output [3:0]trigger_pos 
);