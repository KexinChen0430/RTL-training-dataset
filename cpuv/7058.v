module dff_64 ( clk, d, q ); 
	input clk; 
	input [63:0] d; 
	output [63:0] q; 
	reg [63:0] q; 
`ifdef RANDOM_INIT
	initial
	$random_init("q"); 
`endif
	always @(posedge clk) begin 
	q <= d; 
	end
endmodule 