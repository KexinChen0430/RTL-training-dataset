module's working mode.
::range
0 for Pipelines, 1 for Req-ack
*/
parameter[0 : 0] work_mode = 0; 
parameter color_channels = 3; 
parameter[3: 0] color_width = 8; 
input clk; 
input rst_n; 
input in_enable; 
input [color_channels * color_width - 1 : 0] in_data; 
output out_ready; 
output[color_channels * color_width - 1 : 0] out_data; 
reg reg_out_ready; 
reg[color_channels * color_width - 1 : 0] reg_out_data; 
genvar i; 
generate
	always @(posedge clk or negedge rst_n or negedge in_enable) begin 
		if(~rst_n | ~in_enable) 
			reg_out_ready <= 0; 
		else
			reg_out_ready <= 1; 
	end
	assign out_ready = reg_out_ready; 
	if(work_mode == 0) begin 
		always @(posedge clk) 
			reg_out_data <= ~in_data; 
	end else begin 
		always @(posedge in_enable) 
			reg_out_data <= ~in_data; 
	end
	assign out_data = out_ready == 0 ? 0 : reg_out_data; 
endgenerate
endmodule