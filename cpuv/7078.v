module dff_13 ( clk, d, q ); 
	input clk; 
	input [12:0] d; 
	output [12:0] q; 
	reg [12:0] q; 
`ifdef RANDOM_INIT
	initial
	$random_init("q"); 
`endif
	always @(posedge clk) begin 
	q <= d; 
	end
endmodule 