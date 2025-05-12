module Debounce(
	lineout, 
	linein,  
	reset,   
	clk      
);
	parameter TIME = 0; 
	`include "definition/Definition.v" 
	output reg lineout;
	input linein;
	input clk;
	input reset;
	reg [WORD-1:0] count;
	reg lineina;
	reg lineinb;
	wire toggle;
	assign toggle = lineina ^^ lineinb;
	always @(posedge clk) begin
		if(reset)								count <= 0; 
		else if(!toggle) 
			if(count != TIME)					count <= count + 1; 
			else								count <= count; 
		else									count <= 0; 
	end
	always @(posedge clk) begin
		if(reset)								lineout <= lineinb; 
		else if((count == TIME) && !toggle)	lineout <= lineinb; 
		else									lineout <= lineout; 
	end
	always @(posedge clk) begin
		lineina <= linein; 
		lineinb <= lineina; 
	end
endmodule 