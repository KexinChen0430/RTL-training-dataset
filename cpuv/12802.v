module Radix_Counter( 
	carry_in,	carry_out,	count, 
	reset,
	clk
);
	parameter RADIX = 0; 
	`include "definition/Definition.v" 
	input					carry_in; 
	output					carry_out; 
	output	reg	[WORD-1:0]	count; 
	input					reset; 
	input					clk; 
	assign carry_out = (count == RADIX-1) && carry_in; 
	always @(posedge clk) begin 
				if(reset)					count	<=	0; 
		else	if(carry_in && carry_out)	count	<=	0; 
		else	if(carry_in)				count	<=	count+1; 
		else								count	<=	count; 
	end 
endmodule 