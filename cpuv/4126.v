module build_tree (
	input wire in, 
	output [15:0] reg out, 
	output  [3:0] reg out_addr, 
	output        reg out_valid, 
	output        reg done, 
	input wire CLK, 
	input wire Reset, 
	input wire EN 
 );