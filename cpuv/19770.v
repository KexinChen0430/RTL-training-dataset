module uut ( 
	input clk, 
	input d, r, e, 
	output [`MAXQ:0] q 
);
	reg q0; 
	always @(posedge clk) begin 
		if (r) 
			q0 <= 0; 
		else if (e) 
			q0 <= d; 
	end
	reg q1; 
	always @(posedge clk, posedge r) begin 
		if (r) 
			q1 <= 0; 
		else if (e) 
			q1 <= d; 
	end
	reg q2; 
	always @(posedge clk, negedge r) begin 
		if (!r) 
			q2 <= 0; 
		else if (!e) 
			q2 <= d; 
	end
	assign q = {q2, q1, q0}; 
endmodule 