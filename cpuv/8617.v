module i2s_out(
	input clock, 
	input reset, 
	input[15:0] left_data, 
	input[15:0] right_data, 
	output mclk, 
	output lrck, 
	output reg sdin); 
	reg [3:0] data_pos; 
	initial 
		begin
			data_pos <= 4'b0; 
			sdin <= 1'b0; 
		end
	assign mclk = clock;
	lrck_divider lrck_gen(
			  .clock(clock),
			  .reset(reset),
			  .clock_out(lrck)
			  );
	wire sclk;
	sclk_divider sclk_gen(
			  .clock(clock),
			  .reset(reset),
			  .clock_out(sclk)
			  );
	always @ (negedge sclk or posedge reset)
		begin
			if(reset) 
				begin
					data_pos <= 4'b0; 
					sdin <= 1'b0; 
				end
			else 
				begin
					if(lrck) 
						begin
							if(data_pos == 4'd0) 
								begin
									sdin <= 1'b0; 
								end
							else 
								begin
									sdin <= right_data[data_pos]; 
								end
						end
					else 
						begin
							if(data_pos == 4'd0) 
								begin
									sdin <= 1'b0; 
								end
							else 
								begin
									sdin <= left_data[data_pos]; 
								end
						end
					data_pos <= data_pos - 1;
				end
		end
endmodule