module obtained from the input vector 
reg [NUM_ENTRIES_BIT-1:0]fifo_head_pos; 
reg [NUM_ENTRIES_BIT-1:0]fifo_tail_pos; 
reg [NUM_ENTRIES_BIT-1:0]loop_variable; 
always@(posedge clk) 
begin
	if(reset) 
	begin
		data_out = INITIAL_VALUE; 
		fifo_head_pos = INITIAL_VALUE; 
		fifo_tail_pos = INITIAL_VALUE; 
		loop_variable = INITIAL_VALUE; 
		control_in = INITIAL_VALUE; 
		data_in = INITIAL_VALUE; 
		fifo_valid_invalid_bit = INITIAL_VALUE; 
		empty_flag = `FIFO_NOT_EMPTY; 
		full_flag = `FIFO_NOT_FULL; 
	end else 
		begin
			if(fifo_tail_pos == fifo_head_pos) 
			begin
				if(fifo_valid_invalid_bit[fifo_tail_pos] == `DATA_INVALID && fifo_valid_invalid_bit[fifo_head_pos] == `DATA_INVALID) 
					begin
					empty_flag = `FIFO_EMPTY; 
					full_flag = `FIFO_NOT_FULL; 
				end else 
					begin
						empty_flag = `FIFO_NOT_EMPTY; 
						full_flag = `FIFO_FULL; 
					end
			end else 
				begin
					empty_flag = `FIFO_EMPTY; 
					full_flag = `FIFO_NOT_FULL; 
				end
			control_in = vector_in[LINE_WIDTH-1:LINE_WIDTH-OPCODE_WIDTH]; 
			data_in = vector_in[LINE_WIDTH-OPCODE_WIDTH-1:LINE_WIDTH-OPCODE_WIDTH-DATA_WIDTH]; 
			case(control_in) 
					`READ: 
							begin
								if(fifo_valid_invalid_bit[fifo_tail_pos] == `DATA_VALID) 
								begin
									data_out = fifo_data[fifo_tail_pos]; 
									fifo_valid_invalid_bit[fifo_tail_pos] = `DATA_INVALID; 
									fifo_tail_pos = fifo_tail_pos + 1'b1; 
								end else 
									begin
										data_out = 'bx; 
									end
							end
					`WRITE: 
							begin
								if(empty_flag == `FIFO_EMPTY && full_flag == `FIFO_NOT_FULL) 
								begin
									fifo_data[fifo_head_pos] = data_in; 
									fifo_valid_invalid_bit[fifo_head_pos] = `DATA_VALID; 
									if(fifo_head_pos == NUM_ENTRIES-1) 
										fifo_head_pos = 0; 
									else 
										fifo_head_pos = fifo_head_pos + 1'b1; 
								end
							end
					default: data_out = 'bx; 
				endcase
		end
end
endmodule