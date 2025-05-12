module DemoInterconnect_uart_transceiver_0_1(i_Clk, i_RX_Serial, o_RX_Done, o_RX_Byte,
  i_TX_Load, i_TX_Byte, o_TX_Active, o_TX_Serial, o_TX_Done)
;
  input i_Clk; 
  input i_RX_Serial; 
  output o_RX_Done; 
  output [7:0]o_RX_Byte; 
  input i_TX_Load; 
  input [7:0]i_TX_Byte; 
  output o_TX_Active; 
  output o_TX_Serial; 
  output o_TX_Done; 
endmodule 