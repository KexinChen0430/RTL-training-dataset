module dff_18 ( clk, d, q ); 
	input clk; 
	input [17:0] d; 
	output [17:0] q; 
	reg [17:0] q; 
`ifdef RANDOM_INIT
	initial
		$random_init("q"); 
`endif
	always @(posedge clk) begin 
		q <= d; 
	end
endmodule 