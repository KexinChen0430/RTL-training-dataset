module des_control
	(
		input wire clk, 
		input wire reset, 
		input wire start_strobe_din, 
		output wire enable_dout, 
		output wire source_dout, 
		output wire active_dout, 
		output reg  round_shift_dout, 
		output wire done_strobe_dout 
    );