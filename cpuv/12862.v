module uart_arbiter #( 
	parameter ACTIVE_LOW		= `UART_DEFAULT_ACTIVE_LOW, 
) (
	input clk,					
	input rx,					
	input tx_active,			
	output tx_allowed,			
	input rx_active,			
	output rx_allowed,			
);
	wire rx_sig; 
	assign rx_sig = ACTIVE_LOW ? ~rx : rx; 
	assign tx_allowed = ~rx_active & rx_sig;
	assign rx_allowed = ~tx_active;
endmodule 