module tx_fct_counter(
			input pclk_tx, 
			input send_null_tx, 
			input enable_tx, 
			input gotfct_tx, 
			input char_sent, 
			output reg [5:0] fct_counter_p 
		     );