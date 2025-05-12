module mcu(clk, clr, OP, PCWriteCond, PCWrite, IorD, MemRead, MemWrite, MemtoReg, IRWrite, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst); 
input clk, clr; 
input [5:0] OP; 
output PCWriteCond, PCWrite, IorD, MemRead, MemWrite, MemtoReg, IRWrite, ALUSrcA, RegWrite, RegDst; 
reg PCWriteCond, PCWrite, IorD, MemRead, MemWrite, MemtoReg, IRWrite, ALUSrcA, RegWrite, RegDst; 
output [1:0] PCSource, ALUOp, ALUSrcB; 
reg [1:0] PCSource, ALUOp, ALUSrcB; 
integer current_state; 
integer next_state; 
always @(current_state) 
begin
	case(current_state) 
	0: 
	begin
		IorD		= 0;
		MemRead		= 1;
		MemWrite	= 0;
		IRWrite		= 1;
		ALUSrcA		= 0;
		ALUSrcB		= 2'b01;
		ALUOp		= 2'b00;
		PCWrite		= 1;
		PCWriteCond	= 0;
		RegWrite	= 0;
		MemtoReg	= 0;
		RegDst		= 0;
		#3; 
		PCSource	= 2'b00;
	end
end
always @(posedge clk) 
begin
	if (clr	== 1'b1) 
		current_state	= -1; 
	else
		current_state	= next_state; 
end
always @(current_state or OP) 
begin
	next_state	= -1; 
	case (current_state) 
	-1: next_state	= 0; 
	0: next_state	= 1; 
	default:
		next_state	= -1; 
	endcase
end
endmodule