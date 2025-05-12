module dff_3 ( clk, d, q );
	input clk;
	input [2:0] d;
	output [2:0] q;
	reg [2:0] q;
`ifdef RANDOM_INIT
	initial
	$random_init("q");
`endif
	always @(posedge clk) begin
	q <= d;
	end
endmodule