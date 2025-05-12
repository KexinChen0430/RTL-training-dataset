module uart_rx(
		 input 			      clk_i, 
		 input 			      rx_i, 
		 output [DATA_LENGTH - 1 : 0] tx_o, 
		 output 		      tx_o_v 
	       );