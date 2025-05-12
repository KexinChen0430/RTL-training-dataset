module alu (
	input clock, 
	input [7:0] opcode, 
	input [`BITS-1:0] tos, 
	input [`BITS-1:0] nos, 
	output [`BITS-1:0] alu_tos, 
	output [`BITS-1:0] alu_nos); 