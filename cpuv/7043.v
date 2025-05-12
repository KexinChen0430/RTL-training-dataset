module dff_8 ( clk, d, q ); 
	input clk; 
	input [7:0] d; 
	output [7:0] q; 
	reg [7:0] q; 
`ifdef RANDOM_INIT
	initial
	$random_init("q"); 
`endif
	always @(posedge clk) begin 
	q <= d; 
	end
endmodule 