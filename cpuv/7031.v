module dff_9 ( clk, d, q );
	input clk;
	input [8:0] d;
	output [8:0] q;
	reg [8:0] q;
`ifdef RANDOM_INIT
	initial
	$random_init("q");
`endif
	always @(posedge clk) begin
	q <= d;
	end
endmodule