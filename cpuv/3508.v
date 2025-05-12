module AngleToPWM(
	input wire [RC_SIGNAL_WIDTH-1:0] pos,
	input wire clk1MHz,
	input wire rst,
	output reg pwm
);