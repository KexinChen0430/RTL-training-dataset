module uart_rx #( 
	parameter DATABITS			= `UART_DEFAULT_DATABITS, 
	parameter PARITY_EVEN		= `UART_DEFAULT_PARITY_EVEN, 
	parameter ACTIVE_LOW		= `UART_DEFAULT_ACTIVE_LOW, 
) (
	input clk,								
	input n_reset,							
	input [23:0] clks_per_sym,				
	input rx,								
	output reg rx_irq,						
	output reg rx_active,					
	output reg [DATABITS - 1 : 0] rx_data,	
	output reg rx_parity,					
	output reg rx_parity_ok,				
	output reg rx_frame_error,				
);
	`include "parity_func.v" 
	localparam COUNT_START_WAIT	= 0;
	localparam COUNT_START		= COUNT_START_WAIT + 1;
	localparam COUNT_BIT0		= COUNT_START + 1;
	localparam COUNT_BIT1		= COUNT_BIT0 + ((DATABITS >= 2) ? 1 : 0);
	localparam COUNT_BIT2		= COUNT_BIT1 + ((DATABITS >= 3) ? 1 : 0);
	localparam COUNT_BIT3		= COUNT_BIT2 + ((DATABITS >= 4) ? 1 : 0);
	localparam COUNT_BIT4		= COUNT_BIT3 + ((DATABITS >= 5) ? 1 : 0);
	localparam COUNT_BIT5		= COUNT_BIT4 + ((DATABITS >= 6) ? 1 : 0);
	localparam COUNT_BIT6		= COUNT_BIT5 + ((DATABITS >= 7) ? 1 : 0);
	localparam COUNT_BIT7		= COUNT_BIT6 + ((DATABITS >= 8) ? 1 : 0);
	localparam COUNT_BIT8		= COUNT_BIT7 + ((DATABITS >= 9) ? 1 : 0);
	localparam COUNT_PARITY		= COUNT_BIT8 + 1;
	localparam COUNT_STOP0		= COUNT_PARITY + 1;
	wire rx_sig; 
	wire rx_start; 
	wire rx_falling; 
	assign rx_sig = ACTIVE_LOW ? ~rx : rx; 
	edge_detect rx_edge(.clk(clk), .signal(rx_sig), .falling(rx_falling));
	reg [3:0] sym_count; 
	reg [DATABITS - 1 : 0] rx_buf; 
	reg rx_parity_buf; 
	reg rx_frame_error_start; 
	reg symclk_n_reset; 
	wire symclk_sample; 
	wire symclk_end; 
	uart_symclk symclk (
		.clk(clk),
		.n_reset(symclk_n_reset),
		.clks_per_sym(clks_per_sym),
		.sample(symclk_sample),
		.symend(symclk_end),
	);
	wire calc_rx_parity; 
	assign calc_rx_parity = parity9(PARITY_EVEN ? EVEN : ODD,
									(DATABITS >= 1) ? rx_buf[0] : 0,
									(DATABITS >= 2) ? rx_buf[1] : 0,
									(DATABITS >= 3) ? rx_buf[2] : 0,
									(DATABITS >= 4) ? rx_buf[3] : 0,
									(DATABITS >= 5) ? rx_buf[4] : 0,
									(DATABITS >= 6) ? rx_buf[5] : 0,
									(DATABITS >= 7) ? rx_buf[6] : 0,
									(DATABITS >= 8) ? rx_buf[7] : 0,
									(DATABITS >= 9) ? rx_buf[8] : 0); 
	initial begin 
		rx_irq <= 0;
		rx_active <= 0;
		rx_data <= 0;
		rx_parity <= 0;
		rx_parity_ok <= 0;
		rx_frame_error <= 0;
		symclk_n_reset <= 0;
		sym_count <= COUNT_START_WAIT;
		rx_buf <= 0;
		rx_parity_buf <= 0;
		rx_frame_error_start <= 0;
	end
	always @(posedge clk) begin
	end
endmodule