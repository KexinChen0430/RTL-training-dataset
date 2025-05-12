module dff_48 ( clk, d, q );
	input clk;
	input [47:0] d;
	output [47:0] q;
	reg [47:0] q;
`ifdef RANDOM_INIT
	initial
	$random_init("q");
`endif
	always @(posedge clk) begin
	q <= d;
	end
endmodule