module dff_68 ( clk, d, q ); 
input clk; 
input [67:0] d; 
output [67:0] q; 
reg [67:0] q; 
`ifdef RANDOM_INIT 
	initial
	$random_init("q"); 
`endif 
always @(posedge clk) begin 
	q <= d; 
	end
endmodule 