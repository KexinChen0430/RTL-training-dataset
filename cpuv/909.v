module i2s_audio (
	input clk_i,          
	input [15:0] left_i,  
	input [15:0] right_i, 
	output reg [3:0] i2s_o,   
	output reg lrclk_o,       
	output sclk_o             
	);
	reg [5:0] bit_cntr = 0;      
	reg [3:0] i2s = 0;           
	reg [63:0] shift_reg = 64'd0; 
	reg delayed_out = 0;         
	reg [15:0] left_buffer[0:2];  
	reg [15:0] right_buffer[0:2]; 
	assign sclk_o = clk_i;
	always @(negedge clk_i)
	begin
		lrclk_o <= bit_cntr[5]; 
		i2s_o <= i2s;           
	end
	always @(posedge clk_i)
	begin
		bit_cntr <= bit_cntr + 1'b1; 
	end
	always @(negedge clk_i)
	begin
		if (bit_cntr == 6'd63) 
		begin
			{delayed_out, shift_reg} <= {shift_reg[63], left_buffer[0], 16'd0, right_buffer[0], 16'd0};
		end
		else 
		begin
			{delayed_out, shift_reg} <= {shift_reg, 1'b0};
		end
	end
	always @(posedge clk_i)
	begin
		i2s <= {4{delayed_out}};
	end
	always @(posedge clk_i)
	begin
		{left_buffer[0], left_buffer[1], left_buffer[2]} <= {left_buffer[1], left_buffer[2], left_i};
		{right_buffer[0], right_buffer[1], right_buffer[2]} <= {right_buffer[1], right_buffer[2], right_i};
	end
endmodule