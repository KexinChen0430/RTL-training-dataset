module bit_capture_data( 
			input negedge_clk, 
			input posedge_clk, 
			input rx_resetn, 
			input rx_din, 
			output reg bit_d_0,
			output reg bit_d_1,
			output reg bit_d_2,
			output reg bit_d_3,
			output reg bit_d_4,
			output reg bit_d_5,
			output reg bit_d_6,
			output reg bit_d_7,
			output reg bit_d_8,
			output reg bit_d_9
		  );
always@(posedge posedge_clk or negedge rx_resetn) 
begin
	if(!rx_resetn) 
	begin
		bit_d_1  <= 1'b0; 
		bit_d_3  <= 1'b0; 
		bit_d_5  <= 1'b0; 
		bit_d_7  <= 1'b0; 
		bit_d_9  <= 1'b0; 
	end
	else 
	begin
		bit_d_1  <= rx_din; 
		bit_d_3  <= bit_d_1; 
		bit_d_5  <= bit_d_3; 
		bit_d_7  <= bit_d_5; 
		bit_d_9  <= bit_d_7; 
	end
end
always@(posedge negedge_clk or negedge rx_resetn) 
begin
	if(!rx_resetn) 
	begin
		bit_d_0 <= 1'b0; 
		bit_d_2 <= 1'b0; 
		bit_d_4 <= 1'b0; 
		bit_d_6 <= 1'b0; 
		bit_d_8 <= 1'b0; 
	end
	else 
	begin
		bit_d_0 <= rx_din; 
		bit_d_2 <= bit_d_0; 
		bit_d_4 <= bit_d_2; 
		bit_d_6 <= bit_d_4; 
		bit_d_8 <= bit_d_6; 
	end
end
endmodule 