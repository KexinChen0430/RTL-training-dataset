module pext_p2_8 ( clk, d, q ); 
	input clk; 
	input d; 
	output q; 
	reg q; 
	reg c_q; 
	reg [2:0] r_cnt; 
	reg [2:0] c_cnt; 
	reg [2:0] cig_zerocnt; 
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
	cig_zerocnt = 3'b0; 
	c_cnt = d ? ~cig_zerocnt : {r_cnt - ((|r_cnt) ? 3'b1 : 3'b0)}; 
	c_q = d | (|r_cnt); 
	end
endmodule 