module
	wire	[31:0]	pipe_tx_data	= send_data;
	wire	[3:0]	pipe_tx_datak	= send_datak;
	assign			phy_pipe_tx_data	= pipe_tx_data_swap;
	assign			phy_pipe_tx_datak	= pipe_tx_datak_swap;
	wire	[1:0]	pipe_rx_valid		= phy_pipe_rx_valid;
	wire	[5:0]	pipe_rx_status		= phy_rx_status;
	wire	[1:0]	pipe_phy_status		= phy_phy_status;
	wire	[3:0]	pipe_rx_datak_swap	= phy_pipe_rx_datak;
	wire	[31:0]	pipe_rx_data_swap	= phy_pipe_rx_data;
	wire	[3:0]	pipe_rx_datak = {	pipe_rx_datak_swap[0], pipe_rx_datak_swap[1],
										pipe_rx_datak_swap[2], pipe_rx_datak_swap[3] };
	wire	[31:0]	pipe_rx_data = {	pipe_rx_data_swap[7:0], pipe_rx_data_swap[15:8],
										pipe_rx_data_swap[23:16], pipe_rx_data_swap[31:24] };
endmodule