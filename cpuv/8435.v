module Ctr( 
    input [5:0] opCode, 
    output regDst, 
    output aluSrc, 
    output memToReg, 
    output regWrite, 
    output memRead, 
    output memWrite, 
    output branch, 
    output [1:0] aluOp, 
    output jump 
    );
	reg regDst; 
	reg aluSrc; 
	reg memToReg; 
	reg regWrite; 
	reg memRead; 
	reg memWrite; 
	reg branch; 
	reg[1:0] aluOp; 
	reg jump; 
	always @(opCode) 
	begin
	case(opCode) 
	    6'b000010: 
		begin
		    regDst=0; 
			aluSrc=0; 
			memToReg=0; 
			regWrite=0; 
			memRead=0; 
			memWrite=0; 
			branch=0; 
			aluOp=2'b00; 
			jump=1; 
		end
		6'b000000: 
		begin
		   regDst=1; 
			aluSrc=0; 
			memToReg=0; 
			regWrite=1; 
			memRead=0; 
			memWrite=0; 
			branch=0; 
			aluOp=2'b10; 
			jump=0; 
		end
		6'b100011: 
		begin
			regDst=0; 
			aluSrc=1; 
			memToReg=1; 
			regWrite=1; 
			memRead=1; 
			memWrite=0; 
			branch=0; 
			aluOp=2'b00; 
			jump=0; 
		end
		6'b101011: 
		begin
			aluSrc=1; 
			regWrite=0; 
			memRead=0; 
			memWrite=1; 
			branch=0; 
			aluOp=2'b00; 
			jump=0; 
		end
		6'b000100: 
		begin
			aluSrc=0; 
			regWrite=0; 
			memRead=0; 
			memWrite=0; 
			branch=1; 
			aluOp=2'b01; 
			jump=0; 
		end
		default 
		begin
			regDst=0; 
			aluSrc=0; 
			memToReg=0; 
			regWrite=0; 
			memRead=0; 
			memWrite=0; 
			branch=0; 
			aluOp=2'b00; 
			jump=0; 
		end
	endcase 
	end 
endmodule 