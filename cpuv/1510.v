module ballpos(
	clk,            
	reset,          
	speed,          
	dir_x,          
	dir_y,          
	value_x,        
	value_y         
	);
	input clk;
	input [4:0] speed;					
	input reset;
	input dir_x, dir_y;
	output [10:0] value_x, value_y;		
	reg [10:0] value_x, value_y;
	initial begin
		value_x <= `hc / 2 - (`ballsize / 2);
		value_y <= `va + 7;
	end
	always @ (posedge clk or posedge reset) begin
		if (reset) begin
			value_x <= `hc / 2 - (`ballsize / 2);
			value_y <= `va + 7;
		end
		else begin
			if (dir_x) begin
				value_x <= value_x + speed;
			end
			else begin
				value_x <= value_x - speed;
			end
			if (dir_y) begin
				value_y <= value_y + speed;
			end
			else begin
				value_y <= value_y - speed;
			end
		end
	end
endmodule