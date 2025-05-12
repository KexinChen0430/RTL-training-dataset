module 
	always @ (*) begin 
		next_state = current_state; 
		case (current_state) 
			state_rst : begin  
				if (!send_data) begin 
					next_state = state_idle; 
				end
			end
			state_idle : begin  
				next_state = state_delay; 
			end
			state_delay : begin  
				if (delay_cnt >= delay) begin 
					next_state = state_check_block; 
				end
			end
			state_check_block : begin  
				if ( (!fifo_busy) && (!fifo_full)) begin 
					next_state = state_start_send; 
				end
			end
			state_start_send : begin  
				next_state = state_cnt_increase; 
			end
			state_cnt_increase : begin  
				next_state = state_idle; 
			end
			default : next_state = state_rst; 
		endcase 
	end 
endmodule 