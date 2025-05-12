module m_instruction_logic_unit (w_jump_flag, w_data_mem_write_flag, w_store_word_flag, w_store_pc_flag, w_load_word_flag, w_write_back_flag, w_write_back_reg, w_bus_wordin, w_cf, w_clock);
	output w_jump_flag, w_data_mem_write_flag, w_store_word_flag, w_store_pc_flag, w_load_word_flag, w_write_back_flag;
	output [3:0]  w_write_back_reg;
	input w_cf, w_clock;
	input [7:0] w_bus_wordin;
	reg r_jump_flag, r_data_mem_write_flag, r_store_word_flag, r_store_pc_flag, r_load_word_flag, r_write_back_flag;
	reg [3:0] r_write_back_reg;
	assign w_jump_flag = r_jump_flag;
	assign w_data_mem_write_flag = r_data_mem_write_flag;
	assign w_store_word_flag = r_store_word_flag;
	assign w_store_pc_flag = r_store_pc_flag;
	assign w_load_word_flag = r_load_word_flag;
	assign w_write_back_flag = r_write_back_flag;
	assign w_write_back_reg[3:0] = r_write_back_reg[3:0];
	initial begin
		r_jump_flag <= 0;
		r_data_mem_write_flag <= 0;
		r_store_word_flag <= 0;
		r_store_pc_flag <= 0;
		r_load_word_flag <= 0;
		r_write_back_flag <= 0;
		r_write_back_reg[3:0] <= 4'b0000;
	end
	always @ (w_clock, w_cf, w_bus_wordin) begin
	end
endmodule