module's working mode.
	parameter[0 : 0] work_mode = 0;
	parameter[3 : 0] window_width = 3;
	input clk;
	input rst_n;
	input[window_width * window_width - 1 : 0] template;
	input in_enable;
	input [window_width * window_width - 1 : 0] in_data;
	output out_ready;
	output out_data;
	reg reg_out_data;
	reg reg_out_ready;
	generate
		always @(posedge clk or negedge rst_n or negedge in_enable) begin
			if(~rst_n || ~in_enable) begin
				reg_out_ready <= 0;
			end else begin
				reg_out_ready <= 1;
			end
		end
		assign out_ready = reg_out_ready;
		if(work_mode == 0) begin
			always @(posedge clk)
				reg_out_data <= in_data == template ? 1 : 0;
		end else begin
			always @(posedge in_enable)
				reg_out_data <= in_data == template ? 1 : 0;
		end
		assign out_data = out_ready ? reg_out_data : 0;
	endgenerate
endmodule