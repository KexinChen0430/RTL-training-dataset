module dff_4 ( clk, d, q );
	input clk;
	input [3:0] d;
	output [3:0] q;
	reg [3:0] q;
`ifdef RANDOM_INIT
	initial
	$random_init("q");
`endif
	always @(posedge clk) begin
	q <= d;
	end
endmodule