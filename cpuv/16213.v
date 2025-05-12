module counter
reg [4:0] clk_counter;
wire slow_clk;
assign slow_clk = !clk_counter;
always @(posedge sys_clk or posedge sys_rst) begin : clock_divider
	if(sys_rst)
		clk_counter <= clk_divider - 4'b1;
	else begin
		clk_counter <= clk_counter - 4'd1;
		if(slow_clk)
			clk_counter <= clk_divider - 4'b1;
	end
end
reg uart_rx1;
reg uart_rx2;
always @(posedge sys_clk) begin : synchronizer
	uart_rx1 <= uart_rx;
	uart_rx2 <= uart_rx1;
end
reg rx_busy;
reg [4:0] rx_divcount;
reg [3:0] rx_bitcount;
reg [7:0] rx_reg;
always @(posedge sys_clk or posedge sys_rst) begin : error_count
	if( sys_rst ) begin
		rx_error_count <= 8'd0;
	end
	else begin
		if( rx_done && rx_error ) rx_error_count <= rx_error_count + 1'd1;
	end
end
always @(posedge sys_clk or posedge sys_rst) begin : rx_logic
	if(sys_rst) begin
		rx_done <= 1'b0;
		rx_busy <= 1'b0;
		rx_divcount  <= 5'd0;
		rx_bitcount <= 4'd0;
		rx_data		<= 8'd0;
		rx_reg    <= 8'd0;
		rx_error <= 1'b0;
	end else begin
		rx_done <= 1'b0;
		if(slow_clk) begin
			if(~rx_busy) begin 
				if(~uart_rx2) begin 
					rx_busy <= 1'b1;
					rx_divcount <= { 1'b0, uart_divider[4:1] }; 
					rx_bitcount  <= 4'd0;
					rx_reg       <= 8'h0;
				end
			end else begin
				if( !rx_divcount ) begin 
					rx_bitcount  <= rx_bitcount + 4'd1;
					rx_divcount <= uart_divider;	
					rx_error     <= 1'b0;
					case( rx_bitcount )
						4'd0: 
							if(uart_rx2)
								rx_busy <= 1'b0;
						4'd9: begin 
							rx_busy <= 1'b0;
							if(uart_rx2) begin 
								rx_data <= rx_reg;
								rx_done <= 1'b1;
							end else begin 
								rx_done  <= 1'b1;
								rx_error <= 1'b1;
								end
							end
							default: 
								rx_reg <= {uart_rx2, rx_reg[7:1]};
					endcase
				end
				else rx_divcount <= rx_divcount - 1'b1;
			end
		end
	end
end
reg tx_busy;
reg [3:0] tx_bitcount;
reg [4:0] tx_divcount;
reg [7:0] tx_reg;
always @(posedge sys_clk or posedge sys_rst) begin :tx_logic
	if(sys_rst) begin
		tx_done <= 1'b0;
		tx_busy <= 1'b0;
		uart_tx <= 1'b1;
	end else begin
		tx_done <= 1'b0;
		if(tx_wr) begin
			tx_reg <= tx_data;
			tx_bitcount <= 4'd0;
			tx_divcount <= uart_divider;
			tx_busy <= 1'b1;
			uart_tx <= 1'b0;
`ifdef SIMULATION
`endif
		end else if(slow_clk && tx_busy) begin
			if( !tx_divcount ) begin
				tx_bitcount <= tx_bitcount + 4'd1;
				tx_divcount <= uart_divider;	
				if( tx_bitcount < 4'd8 ) begin
						uart_tx <= tx_reg[0];
						tx_reg <= {1'b0, tx_reg[7:1]};
						end
				else begin
					uart_tx <= 1'b1; 
					if( tx_bitcount==4'd10 ) begin
						tx_busy <= 1'b0;
						tx_done <= 1'b1;
					end
				end
			end
			else tx_divcount  <= tx_divcount - 1'b1;
		end
	end
end
endmodule