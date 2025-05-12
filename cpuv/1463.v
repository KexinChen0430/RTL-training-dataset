module ClockManager(
	 (* buffer_type = "ibufg" *) input CLK_IN, 
	 input RESET_IN, 
	 output CLK_MAIN, 
	 output reg RESET 
	);