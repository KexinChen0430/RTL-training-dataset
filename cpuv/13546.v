module gpio_tx(
	#(
	parameter GPIO_DATA_WIDTH = 8 
	)
	(
	output	[GPIO_DATA_WIDTH-1:0]	gpio_rd_data, 
	output							gpio_rd_par,  
	input							gpio_rd_err,  
	output							gpio_rd_req,  
	input							gpio_rd_ack,  
	input	[GPIO_DATA_WIDTH-1:0]	gpio_n2p_data, 
	input							gpio_n2p_req,  
	output							gpio_n2p_done, 
	input							reset, 
	input							clk    
	);
	always@(posedge clk)
	begin
		gpio_rd_ack_reg <= gpio_rd_ack; 
		gpio_rd_err_reg	<= gpio_rd_err; 
	end
	localparam
		GPIO_TX_IDLE = 2'h0,          
		GPIO_TX_CHECK = 2'h1,         
		GPIO_TX_CHECK_DONE = 2'h2,    
		GPIO_TX_DONE = 2'h3;          
	always@(posedge clk)
	begin
		gpio_tx_state <= gpio_tx_state_nxt; 
	end
	always@(*)
	begin
		if(reset)
			gpio_tx_state_nxt = GPIO_TX_IDLE; 
		else
		begin
			case(gpio_tx_state) 
				GPIO_TX_IDLE:
				begin
					if(gpio_wr_req_reg) 
						gpio_tx_state_nxt = GPIO_TX_CHECK;
					else
						gpio_tx_state_nxt = GPIO_TX_IDLE; 
				end
				GPIO_TX_CHECK:
					gpio_tx_state_nxt = GPIO_TX_CHECK_DONE; 
				GPIO_TX_CHECK_DONE:
					gpio_tx_state_nxt = GPIO_TX_DONE; 
				GPIO_TX_DONE:
					if(!gpio_wr_req_reg) 
						gpio_tx_state_nxt = GPIO_TX_IDLE;
					else
						gpio_tx_state_nxt = GPIO_TX_DONE; 
				default:
					gpio_tx_state_nxt <= gpio_tx_state; 
			endcase
		end
	end
	always@(posedge clk)
	begin											
		if(gpio_tx_state == GPIO_TX_CHECK_DONE && !gpio_wr_err)
	end
	always@(posedge clk)
	begin
		if(gpio_tx_state == GPIO_TX_CHECK_DONE)
			gpio_wr_ack = 1'b1; 
		else if(gpio_tx_state == GPIO_TX_IDLE)
			gpio_wr_ack = 1'b0; 
		else
			gpio_wr_ack = gpio_wr_ack; 
	end
	always@(posedge clk)
	begin											
		if(gpio_tx_state == GPIO_TX_CHECK)
		begin
			if((^ gpio_wr_data_reg) ^ gpio_wr_par_reg) 
				gpio_wr_err = 1'b1; 
			else
				gpio_wr_err = 1'b0; 
		end
		else
			gpio_wr_err = gpio_wr_err; 
	end
endmodule