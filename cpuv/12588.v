module PIO32( 
input rsi_MRST_reset, 
input csi_MCLK_clk, 
input [31:0] avs_gpio_writedata, 
output [31:0] avs_gpio_readdata, 
input [2:0] avs_gpio_address, 
input [3:0] avs_gpio_byteenable, 
input avs_gpio_write, 
input avs_gpio_read, 
output avs_gpio_waitrequest, 
inout [31:0] coe_P, 
);
reg [31:0] io_data; 
reg [31:0] io_out_en; 
reg [31:0] read_data; 
assign avs_gpio_readdata = read_data; 
assign avs_gpio_waitrequest = 1'b0; 
assign coe_P = (io_out_en) ? io_data : 32'bz; 
always@(posedge csi_MCLK_clk or posedge rsi_MRST_reset)
begin
	if(rsi_MRST_reset) begin 
		read_data <= 0; 
	end
	else begin 
		case(avs_gpio_address) 
			2: read_data <= coe_P; 
			4: read_data <= io_out_en; 
			default: read_data <= 0; 
		endcase
	end
end
always@(posedge csi_MCLK_clk or posedge rsi_MRST_reset)
begin
	if(rsi_MRST_reset) begin 
		io_data <= 0; 
		io_out_en <= 0; 
	end
	else begin 
		if(avs_gpio_write) begin 
			case(avs_gpio_address) 
				2: io_data <= avs_gpio_writedata; 
				4: io_out_en <= avs_gpio_writedata; 
				default: begin end 
			endcase
		end
	end
end
endmodule 