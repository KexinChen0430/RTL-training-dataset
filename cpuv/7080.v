module dff_7 ( clk, d, q ); 
input clk; 
input [6:0] d; 
output [6:0] q; 
reg [6:0] q; 
`ifdef RANDOM_INIT
	initial
	$random_init("q"); 
`endif
always @(posedge clk) begin 
	q <= d; 
	end
endmodule 