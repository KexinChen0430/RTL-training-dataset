module antiDroopIIR (
	input clk, 
	input trig, 
	input signed [12:0] din, 
	input signed [6:0] tapWeight, 
	input accClr_en, 
	input oflowClr, 
	output reg oflowDetect = 1'd0, 
	output reg signed [15:0] dout = 16'sd0); 