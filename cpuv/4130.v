module UART_Tx #( 
 parameter N    = 5, 
 parameter Full = 5'd29 
)(
 input Reset, 
 input Clk, 
 input [7:0]Data, 
 input      Send, 
 output reg Busy, 
 output reg Tx	
);