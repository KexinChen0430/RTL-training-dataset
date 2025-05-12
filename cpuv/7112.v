module dff_1 ( clk, d, q ); 
	input clk; 
	input d; 
	output q; 
	reg q; 
`ifdef RANDOM_INIT 
	initial
	$random_init("q"); 
`endif 
	always @(posedge clk) begin 
	q <= d; 
	end 
endmodule 