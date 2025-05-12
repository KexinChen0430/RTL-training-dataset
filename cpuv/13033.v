module dram(
	input clk, 
	input rst_n, 
	output reg [9:0] ra, 
	inout [15:0] rd, 
	output reg rwe_n, 
	output reg rucas_n, 
	output reg rlcas_n, 
	output reg rras0_n, 
	output reg rras1_n, 
	input [20:0] addr, 
	input req, 
	input rnw, 
	output reg cbeg, 
	output reg rrdy, 
	output reg [15:0] rddata, 
	input [15:0] wrdata, 
	input [1:0] bsel 
);