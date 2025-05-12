module myregister (clk, rst, d, q, ena); 
	input clk, rst, ena; 
	output [`DATA_BITS-1:0] q; 
	reg [`DATA_BITS-1:0] q; 
	input [`DATA_BITS-1:0] d; 
	always @(posedge clk or posedge rst) begin 
		if (rst == 1) begin 
			q <= 0; 
		end else if (ena) begin 
			q <= d; 
		end
	end
endmodule 