module UART_RX (
  input clk,            
  input rst,            
  input RX,             
  output reg busy,      
  output reg [7:0] data 
);