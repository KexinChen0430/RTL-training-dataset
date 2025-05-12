module Control_Unit(RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, Jump, SignExtend, ALUOp, Opcode); 
   input [5:0] Opcode; 
   output RegDst; 
   output ALUSrc; 
   output MemToReg; 
   output RegWrite; 
   output MemRead; 
   output MemWrite; 
   output Branch; 
   output Jump; 
   output SignExtend; 
   output [3:0] ALUOp; 
	reg	RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, Jump, SignExtend; 
	reg  [3:0] ALUOp; 
	always @ (Opcode) begin 
		case(Opcode) 
			6'b000000: begin 
				RegDst <=  1; 
				ALUSrc <= 0; 
				MemToReg <= 0; 
				RegWrite <= 1; 
				MemRead <= 0; 
				MemWrite <= 0; 
				Branch <= 0; 
				Jump <= 0; 
				SignExtend <= 1'bX; 
				ALUOp <= 4'b1111; 
			end
			`OPCODE_ADDI: begin 
				RegDst <= 0; 
				ALUSrc <= 1; 
				MemToReg <= 0; 
				RegWrite <= 1; 
				MemRead <= 0; 
				MemWrite <= 0; 
				Branch <= 0; 
				Jump <= 0; 
				SignExtend <= 1; 
				ALUOp <= `ADD; 
			end
			`OPCODE_ADDIU: begin 
				RegDst <= 0; 
				ALUSrc <= 1; 
				MemToReg <= 0; 
				RegWrite <= 1; 
				MemRead <= 0; 
				MemWrite <= 0; 
				Branch <= 0; 
				Jump <= 0; 
				SignExtend <= 1; 
				ALUOp <= `ADDU; 
			end
			`OPCODE_NOP: begin 
				RegDst <= 1'bX; 
				ALUSrc <= 1'bX; 
				MemToReg <= 1'bX; 
				RegWrite <= 1'bX; 
				MemRead <= 1'bX; 
				MemWrite <= 1'bX; 
				Branch <= 1'bX; 
				Jump <= 1'bX; 
				SignExtend <= 1'bX; 
				ALUOp <= `NOP; 
			end
		endcase 
	end 
endmodule 