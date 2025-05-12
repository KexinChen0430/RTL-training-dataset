module fmrv32im_artya7(CLK100MHZ, GPIO_i, GPIO_o, GPIO_ot, UART_rx, UART_tx)
;
  input CLK100MHZ;
  input [31:0]GPIO_i;
  output [31:0]GPIO_o;
  output [31:0]GPIO_ot;
  input UART_rx;
  output UART_tx;
endmodule