module directly to the
	reg wb_ack;
	assign wb_ack_o = wb_ack;
	reg c_oe;
	reg d_oe;
	assign c_oe_o = c_oe;
	assign d_oe_o = d_oe;
	reg rp_inc;
	wire rp_inc_n = (~sys_reset_i & wb_stb_i & wb_we_i);
	assign rp_inc_o = rp_inc;
	always @(posedge sys_clk_i) begin
		if (sys_reset_i) begin
			c_oe <= 0;
			d_oe <= 0;
			rp_inc <= 0;
			wb_ack <= 0;
		end else begin
			wb_ack <= ~wb_ack & wb_stb_i;
			rp_inc <= rp_inc_n;
			if(wb_stb_i & wb_we_i) begin
				c_oe <= ~wb_dat_9_i;
				d_oe <= ~wb_dat_8_i;
			end
		end
	end
endmodule