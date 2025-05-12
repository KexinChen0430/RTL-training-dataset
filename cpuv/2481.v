module itself.  Note that we haven't
	txuart	#(.INITIAL_SETUP(INITIAL_SETUP)) tx(i_clk, 1'b0, uart_setup,
			r_tx_break, (tx_empty_n), tx_data,
			cts_n, o_uart_tx, tx_busy);
`endif
	assign	wb_tx_data = { 16'h00,
			i_cts_n, txf_status[1:0], txf_err,
			ck_uart, o_uart_tx, tx_break, (tx_busy|txf_status[0]),
			(tx_busy|txf_status[0])?txf_wb_data:8'b00};
	assign	wb_fifo_data = { txf_status, rxf_status };
	always @(posedge i_clk)
		r_wb_addr <= i_wb_addr;
	initial	r_wb_ack = 1'b0;
	always @(posedge i_clk) 
		r_wb_ack <= i_wb_stb;
	initial	o_wb_ack = 1'b0;
	always @(posedge i_clk) 
		o_wb_ack <= i_wb_cyc && r_wb_ack;
	always @(posedge i_clk)
	casez(r_wb_addr)
	UART_SETUP: o_wb_data <= { 1'b0, uart_setup };
	UART_FIFO:  o_wb_data <= wb_fifo_data;
	UART_RXREG: o_wb_data <= wb_rx_data;
	UART_TXREG: o_wb_data <= wb_tx_data;
	endcase
	assign	o_wb_stall = 1'b0;
	wire	unused;
	assign	unused = &{ 1'b0, i_wb_data[31] };
endmodule