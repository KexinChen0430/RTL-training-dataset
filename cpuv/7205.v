module dff_66 ( clk, d, q ); 
	input clk; 
	input [65:0] d; 
	output [65:0] q; 
	reg [65:0] q; 
`ifdef RANDOM_INIT
	initial
	$random_init("q"); 
`endif
	always @(posedge clk) begin 
	q <= d; 
	end
endmodule 