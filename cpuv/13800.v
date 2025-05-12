module baudcounter(clk, rstn, arm, baudce);
	input clk;
	input rstn;
	input arm;
	output reg baudce;
	reg [10:0] baudcntr;
	always @(*)
		baudce <= (baudcntr == `BAUDRATE_DIVISOR) ? 1'b1 : 1'b0; 
	always @(posedge clk or negedge rstn) begin
		if(rstn == 0) 
			baudcntr <= 0; 
		else begin 
			if(arm) begin 
				if(baudcntr == `BAUDRATE_DIVISOR) 
					baudcntr <= 0; 
				else 
					baudcntr <= baudcntr + 1'b1; 
			end else 
				baudcntr <= 0; 
		end
	end
endmodule 