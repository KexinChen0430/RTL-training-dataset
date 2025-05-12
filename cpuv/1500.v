module batpos(
	clk,
	up,
	down,
	reset,
	speed,
	value
	);
	input clk; 
	input up, down;	
	input [4:0] speed;	
	input reset; 
	output [10:0] value;	
	reg [10:0] value; 
	initial begin
		value <= `vc / 2;
	end
	always @ (posedge clk or posedge reset) begin
		if (reset) begin
			value <= `vc / 2;
		end
		else begin
			if (up) begin
				if ((value - speed) > `va) begin
					value <= value - speed;
				end
			end
			else if (down) begin
				if ((value + speed) < (`vc - `batheight)) begin
					value <= value + speed;
				end
			end
		end
	end
endmodule