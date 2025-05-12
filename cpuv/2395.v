module ps2_read_ms(clk,rst,kd,kc,kbs,data,parity_error);
	input clk,rst,kd,kc;
	output kbs;
	output reg parity_error = 1'b0;
	output reg [7:0]data;