module mapping #(
	parameter IN_WIDTH = 128, 
	parameter OUT_WIDTH = 16  
)(
	input wire clk,           
	input wire reset,         
	input wire trigger,       
	input wire [IN_WIDTH-1:0] dataIn, 
	output reg done,          
	output reg [OUT_WIDTH-1:0] dataOut, 
	output reg xorOut	
	);