module alu_risc #(parameter word_sz=8, op_sz=4)
	(	output alu_zero_flag,
		output reg [word_sz-1:0] alu_out,
		input [word_sz-1:0] data_1, data_2,
		input [op_sz-1:0] sel);
	assign alu_zero_flag = ~|alu_out;
	always @(sel or data_1 or data_2)
		case (sel)
			op.NOP: alu_out <= 0;
			op.ADD: alu_out <= data_1 + data_2; 
			op.SUB: alu_out <= data_2 - data_1;
			op.AND: alu_out <= data_1 & data_2;
			op.NOT: alu_out <= ~data_2; 
			default: alu_out <= 0;
		endcase
endmodule