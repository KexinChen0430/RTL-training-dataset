module dff_5 ( clk, d, q ); 
	input clk; 
	input [4:0] d; 
	output [4:0] q; 
	reg [4:0] q; 
`ifdef RANDOM_INIT
	initial
		$random_init("q");
`endif
	always @(posedge clk) begin 
		q <= d; 
	end
endmodule 