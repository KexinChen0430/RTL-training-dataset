module Negedge( 
	linein, 
	lineout, 
	reset, 
	clk 
);
	`include "definition/Definition.v" 
	input						linein; 
	output						lineout; 
	reg						linehold; 
	input						reset; 
	input						clk; 
	always @(posedge clk) begin 
		linehold	<= linein; 
	end
	assign lineout = ((linehold) && (!linein)); 
endmodule 