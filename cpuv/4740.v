module
		rst, 					
		rx, 					
		tx, 					
		transmit, 				
		tx_byte, 				
		received, 				
		rx_byte, 				
		is_receiving, 			
		is_transmitting, 		
		recv_error 				
    );
	always @(posedge clk_96M) begin
		if(rst) begin
			rst <= DISABLE;
		end
		else if(received) begin
			case(state)
				STATE_RCV_REG:
					begin
						register[6:0] = rx_byte[6:0];
						if(rx_byte[7] == 0) begin
							case(register)
								REG_STATUS			: tx_byte[7:0] = status[7:0];
								REG_LED				: tx_byte[7:0] = r_led[7:0];
								REG_MEMADR_RD_LO	: tx_byte[7:0] = memadr_rd[7:0];
								REG_MEMADR_RD_HI	: tx_byte[7:0] = memadr_rd[13:8];
								REG_MEMADR_WR_LO	: tx_byte[7:0] = memadr_wr[7:0];
								REG_MEMADR_WR_HI	: tx_byte[7:0] = memadr_wr[13:8];
								REG_MEM				: state <= STATE_RCV_VAL;				
								REG_TRIG_EN			: tx_byte[7:0] = trig_en[7:0];
								REG_TRIG_VAL		: tx_byte[7:0] = trig_val[7:0];
								REG_CLKDIV_LO		: tx_byte[7:0] = clkdiv[7:0];
								REG_CLKDIV_HI		: tx_byte[7:0] = clkdiv[15:8];
								default				: tx_byte[7:0] = 8'hff;
							endcase
							if(register != REG_MEM) begin
								transmit <= ENABLE;
							end
						end
						else begin
							state <= STATE_RCV_VAL;
						end
					end
				STATE_RCV_VAL:
					begin
						value[7:0] = rx_byte[7:0];
						case(register)
							REG_STATUS			:
								begin
									status[0] = value[0];	
									status[2] = value[2];	
								end
							REG_LED				: r_led[7:0] = value[7:0];
							REG_MEMADR_RD_LO	: memadr_rd[7:0] = value[7:0];
							REG_MEMADR_RD_HI	: memadr_rd[13:8] = value[5:0];
							REG_MEM				: memcnt_rd[7:0] = value[7:0];
							REG_TRIG_EN			: trig_en[7:0] = value[7:0];
							REG_TRIG_VAL		: trig_val[7:0] = value[7:0];
							REG_CLKDIV_LO		: clkdiv[7:0] = value[7:0];
							REG_CLKDIV_HI		: clkdiv[15:8] = value[7:0];
						endcase
						if(register == REG_CLKDIV_LO || register == REG_CLKDIV_HI) begin
							clk_sample_rst = ENABLE;
						end
						state <= STATE_RCV_REG;
					end
			endcase
		end
		else if(is_transmitting) begin
			transmit <= DISABLE;
		end
		else if(!transmit && memcnt_rd) begin
			tx_byte[7:0] = memdata_out[7:0];
			memadr_rd = memadr_rd + 1;
			memcnt_rd = memcnt_rd - 1;
			transmit <= ENABLE;
		end
		else if(status[1] && status[0]) begin
			status[0] = 1'b0;
		end
		else begin
			clk_sample_rst = DISABLE;
		end
	end
	always @(posedge clk_sample) begin
		memwe = DISABLE;
		if(status[0] && !status[1] &&
			(!status[2] || (status[2] && (pin[7:0] & trig_en[7:0]) == trig_val[7:0])))
			begin
			memadr_wr = 14'h00;			
			status[1] = ENABLE;			
		end
		else if(status[1]) begin
			memdata_in[7:0] = pin[7:0];		
			memadr_wr = memadr_wr + 1;		
			memwe = ENABLE;				
			if(!memadr_wr) begin
				status[1] = DISABLE;
			end
		end
	end
	reg [7:0] r_pout = 8'h0;
	always @(posedge clk_24M) begin
		r_pout <= r_pout + 1;
	end
	assign x2en = 1'b1;
	assign led[7:0] = ~r_led[7:0];
	assign pout = r_pout;
endmodule