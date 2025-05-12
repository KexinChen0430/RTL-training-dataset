module dff_6 ( clk, d, q ); 
	input clk; 
	input [5:0] d; 
	output [5:0] q; 
	reg [5:0] q; 
`ifdef RANDOM_INIT
	initial
	$random_init("q"); 
`endif
	always @(posedge clk) begin 
	q <= d; 
	end
endmodule 