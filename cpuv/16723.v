module dilation_basic_block_0
(
	input 		clock, 
	input 		resetn, 
	input 		start, 
	input [31:0] 		input_iterations, 
	input 		valid_in, 
	output 		stall_out, 
	output 		valid_out, 
	input 		stall_in, 
	output 		lvb_bb0_cmp6, 
	input [31:0] 		workgroup_size 
);