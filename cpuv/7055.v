module dff_17 ( clk, d, q ); 
	input clk; 
	input [16:0] d; 
	output [16:0] q; 
	reg [16:0] q; 
`ifdef RANDOM_INIT
	initial
		$random_init("q"); 
`endif
	always @(posedge clk) begin 
		q <= d; 
	end
endmodule 