module can start sniffing for the next byte
);
	reg[31:0] count; 
	reg[7:0] data; 
	always @(posedge clk or posedge rst) begin
		if(rst)	data = 0; 
		else if(wr) begin 
				data = din; 
		end
	end
	wire tick; 
	reg[3:0] state,n_state; 
	parameter s0 = 0;
	parameter s1 = 1;
	parameter s2 = 2;
	parameter s3 = 3;
	parameter s4 = 4;
	parameter s5 = 5;
	parameter s6 = 6;
	parameter s7 = 7;
	parameter s8 = 8;
	parameter s9 = 9;
	always @(posedge clk or posedge rst) begin
		if(rst)	begin
			count <= 0; 
		end
		else	begin
			if(tick)	count <= 0; 
			else	count <= count + 1; 
		end
	end
	assign tick = (count == div) | (wr & (state==0));
	always @(posedge clk or posedge rst) begin
		if(rst)	state <= 0; 
		else if(tick) state <= n_state; 
	end
	always @(state or wr) begin
		if(state == 0) begin
			if(wr)	n_state <= 1; 
			else	n_state <= 0; 
		end
		else if(state < 10)	n_state <= state + 1; 
		else n_state <= 0; 
	end
	always @(*) begin
		case(state)
			4'h0: txd <= 1; 
			4'h1: txd <= 0; 
			4'h2: txd <= data[0]; 
			4'h3: txd <= data[1]; 
			4'h4: txd <= data[2]; 
			4'h5: txd <= data[3];
			4'h6: txd <= data[4];
			4'h7: txd <= data[5];
			4'h8: txd <= data[6];
			4'h9: txd <= data[7]; 
			default: txd <= 1; 
		endcase
	end
	assign rdy = (state == s0);
	reg[15:0] rx_baud_count; 
	wire rx_tick; 
	reg rx_baudgen_rst; 
	always @(posedge clk or posedge rst) begin
		if(rst) rx_baud_count <= 0; 
		else
			if(rx_baudgen_rst | (rx_baud_count == div))	rx_baud_count <= 0; 
			else rx_baud_count <= rx_baud_count + 1; 
	end
	assign rx_tick = (rx_baud_count == div/2);
	reg rx_shift; 
	reg[3:0] rx_bits_rxed,rx_bits_next_rxed; 
	reg[3:0] rx_state,rx_next_state; 
	always @(posedge clk or posedge rst) begin
		if(rst)
			dout <= 0; 
		else
			if(rx_shift)	dout <= { rxd, dout[7:1] }; 
	end
	reg next_valid; 
	always @(posedge clk or posedge rst) begin
		if(rst)
			begin
				rx_state <= 0; 
				rx_bits_rxed <= 0; 
			end
		else
			begin
				rx_bits_rxed <= rx_bits_next_rxed; 
				rx_state <= rx_next_state; 
			end
	end
	always @(*) begin
		rx_next_state <= rx_state; 
		rx_baudgen_rst <= 0; 
		rx_bits_next_rxed <= rx_bits_rxed; 
		rx_shift <= 0; 
		valid <= 0; 
		case(rx_state)
			4'h0: begin
						if(rxd==0)	rx_next_state <= 1; 
					end
			4'h1: begin
						rx_baudgen_rst <= 1; 
						rx_bits_next_rxed <= 0; 
						rx_next_state <= 2; 
					end
			4'h2: begin
						if(rx_tick) rx_next_state <= 3; 
					end
			4'h3: begin
						rx_shift <= 1; 
						rx_bits_next_rxed <= rx_bits_rxed + 1; 
						if(rx_bits_rxed < 8)	rx_next_state <= 2; 
						else	rx_next_state <= 4; 
					end
			4'h4: begin
						if(rx_tick) rx_next_state <= 5; 
					end
			4'h5: begin
						valid <= 1; 
						if(rd)	rx_next_state <= 0; 
					end
			endcase
	end
endmodule