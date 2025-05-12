module ControlUnit(input[5:0] opcode, 
		input[5:0] funct, 
		output reg reg_dst, 
		output reg reg_write, 
		output reg[1:0] alu_src, 
		output reg[3:0] alu_op, 
		output reg branch, 
		output reg mem_write, 
		output reg mem_to_reg, 
        	output reg zero_sign_ext, 
		output reg mult_op, 
		output reg mfhi, 
		output reg mflo); 
always @(opcode, funct) begin 
		reg_dst = 1'bx;
		reg_write = 1'bx;
		alu_src = 2'bxx;
		alu_op = 4'bxxxx;
		branch = 1'bx;
		mem_write = 1'bx;
		mem_to_reg = 1'bx;
		zero_sign_ext = 1'bx;
		mult_op = 1'b0; 
		mfhi = 1'b0; 
		mflo = 1'b0; 
		case (opcode) 
			6'h00: begin 
				reg_dst = 1;
				reg_write = 1;
				alu_src = 0;
				branch = 0;
				mem_write = 0;
				mem_to_reg = 0;
				case (funct) 
				endcase
			end
		endcase
	end
endmodule