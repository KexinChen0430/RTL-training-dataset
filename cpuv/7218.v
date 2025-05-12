module dffl_32 ( clk, ld, d, q ); 
input clk; 
input ld; 
input [31:0] d; 
output [31:0] q; 
reg [31:0] q; 
`ifdef RANDOM_INIT 
	initial
	$random_init("q"); 
`endif 
always @(posedge clk) begin 
if (ld)
	q <= d; 
end 
endmodule 