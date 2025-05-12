module obtained from the input vector 
reg [NUM_ENTRIES_BIT-1:0]lifo_head_pos; 
reg [NUM_ENTRIES_BIT-1:0]lifo_tail_pos; 
reg [NUM_ENTRIES_BIT-1:0]loop_variable; 
always@(posedge clk) 
begin
	if(reset) 
	begin
		data_out = INITIAL_VALUE;
		lifo_head_pos = INITIAL_VALUE;
		lifo_tail_pos = INITIAL_VALUE;
		loop_variable = INITIAL_VALUE;
		control_in = INITIAL_VALUE;
		data_in = INITIAL_VALUE;
		lifo_valid_invalid_bit = INITIAL_VALUE;
		empty_flag = `LIFO_NOT_EMPTY;
		full_flag = `LIFO_NOT_FULL;
	end else 
		begin
			if(lifo_head_pos == INITIAL_VALUE && lifo_tail_pos == INITIAL_VALUE)
			begin
				empty_flag = `LIFO_EMPTY;
				full_flag = `LIFO_NOT_FULL;
			end else
				begin
					if(lifo_head_pos == NUM_ENTRIES-1 && lifo_tail_pos == NUM_ENTRIES-1)
					begin
						empty_flag = `LIFO_NOT_EMPTY;
						full_flag = `LIFO_FULL;
					end else
						begin
							empty_flag = `LIFO_EMPTY;
							full_flag = `LIFO_NOT_FULL;
						end
				end
		control_in = vector_in[LINE_WIDTH-1:LINE_WIDTH-OPCODE_WIDTH]; 
		data_in = vector_in[LINE_WIDTH-OPCODE_WIDTH-1:LINE_WIDTH-OPCODE_WIDTH-DATA_WIDTH]; 
		case(control_in) 
			`POP: 
				begin
					if(lifo_valid_invalid_bit[lifo_tail_pos] == `DATA_VALID) 
					begin
						data_out = lifo_data[lifo_tail_pos]; 
						lifo_valid_invalid_bit[lifo_tail_pos] = `DATA_INVALID; 
						if(lifo_tail_pos == INITIAL_VALUE)
						begin
							lifo_tail_pos = INITIAL_VALUE;
							lifo_head_pos = lifo_head_pos - 1'b1;
						end else
							begin
								if(empty_flag == `LIFO_NOT_EMPTY && full_flag == `LIFO_FULL)
									lifo_tail_pos = lifo_tail_pos - 1'b1;
								else begin
									lifo_tail_pos = lifo_tail_pos - 1'b1;
									lifo_head_pos = lifo_head_pos - 1'b1;
								end
							end
					end else
						begin
							data_out = 'bx; 
						end
				end
			`PUSH: 
				begin
					if(empty_flag == `LIFO_EMPTY && full_flag == `LIFO_NOT_FULL) 
					begin
						lifo_data[lifo_head_pos] = data_in; 
						lifo_valid_invalid_bit[lifo_head_pos] = `DATA_VALID; 
						if(lifo_head_pos == NUM_ENTRIES-1)
						begin
							lifo_tail_pos = lifo_tail_pos + 1'b1;;
							lifo_head_pos = NUM_ENTRIES-1;
						end else begin
							lifo_tail_pos = lifo_head_pos;
							lifo_head_pos = lifo_head_pos + 1'b1;
						end
					end
				end
			default: data_out = 'bx; 
		endcase
	end
end
endmodule