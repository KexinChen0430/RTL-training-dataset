module pext_p2_4 ( clk, d, q ); 
	input clk; 
	input d; 
	output q; 
	reg q; 
	reg c_q; 
	reg [1:0] r_cnt; 
	reg [1:0] c_cnt; 
	reg [1:0] cig_zerocnt; 
`ifdef RANDOM_INIT 
	initial begin
	$random_init("q", "r_cnt"); 
	end
`endif
	always @(posedge clk) begin 
	r_cnt <= 
	(^c_cnt === 1'bx) ? $random : 
	c_cnt; 
	q <= c_q; 
	end
	always @ (d or q or r_cnt) begin 
	cig_zerocnt = 2'b0; 
	c_cnt = d ? ~cig_zerocnt : {r_cnt - ((|r_cnt) ? 2'b1 : 2'b0)}; 
	c_q = d | (|r_cnt); 
	end
endmodule 