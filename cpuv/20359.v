module inst_decoder(
	input [15:0] instruction, 
	output reg [3:0] opcode, 
	output reg [1:0] rs_addr, 
	output reg [1:0] rt_addr, 
	output reg [1:0] rd_addr, 
	output reg [7:0] immediate, 
	output reg RegDst, 
	output reg RegWrite, 
	output reg ALUSrc1, 
	output reg ALUSrc2, 
	output reg [2:0] ALUOp, 
	output reg MemWrite, 
	output reg MemToReg 
);