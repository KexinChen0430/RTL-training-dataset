module uart_tx #(  
	parameter DATABITS					= `UART_DEFAULT_DATABITS,  
	parameter PARITY_EVEN				= `UART_DEFAULT_PARITY_EVEN,  
	parameter STOP						= `UART_DEFAULT_STOP,  
	parameter ACTIVE_LOW				= `UART_DEFAULT_ACTIVE_LOW,  
) (
	input clk,							
	input n_reset,						
	input [23:0] clks_per_sym,			
	output tx,							
	output reg tx_irq,					
	output reg tx_active,				
	input [DATABITS - 1 : 0] tx_data,	
	input tx_trigger,					
);