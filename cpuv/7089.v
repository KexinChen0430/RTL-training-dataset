module dffl_18 ( clk, ld, d, q );
	input clk;
	input ld;
	input [17:0] d;
	output [17:0] q;
	reg [17:0] q;
`ifdef RANDOM_INIT
	initial
	$random_init("q");
`endif
	always @(posedge clk) begin
	if (ld)
	q <= d;
	end
endmodule