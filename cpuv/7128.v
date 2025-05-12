module
		if (~sys_reset_i & we_i & ~full_o) begin
			fifo[wp] <= d_i;
		end
		if (~sys_reset_i & wp_inc_i & ~full_o) begin
			wp <= wp+1;
		end
		if (~sys_reset_i & rp_inc_i & data_available_o) begin
			rp <= rp+1;
		end
	end
endmodule