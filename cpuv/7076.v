module dff_32 ( clk, d, q ); 
	input clk; 
	input [31:0] d; 
	output [31:0] q; 
	reg [31:0] q; 
`ifdef RANDOM_INIT 
	initial
	$random_init("q"); 
`endif 
	always @(posedge clk) begin 
	q <= d; 
	end 
endmodule 