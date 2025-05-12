module sync2r_f_1 ( clk, clear, d, q ); 
	input clk; 
	input clear; 
	input d; 
	output q; 
	reg  q; 
	reg c_q; 
	reg  meta1; 
`ifdef RANDOM_INIT
	reg c_meta2; 
	reg meta2; 
`endif
`ifdef RANDOM_INIT
	reg [31:0] seed; 
	initial
	begin
	$random_init("q", "meta1", "meta2"); 
	$random_value("seed"); 
	end
`endif
	always @ (meta1
`ifdef RANDOM_INIT
	or d or meta2
`endif
	) begin
	c_q = meta1; 
`ifdef RANDOM_INIT
	c_meta2 = (d ^ meta1) & $random(seed); 
	c_q = c_meta2 | ((meta1 ^ meta2) & $random(seed)) |
	(d & meta1 & meta2); 
	c_meta2 = c_meta2 | (d & meta1); 
`endif
	end
	always @(posedge clk or posedge clear) begin 
	if (clear) begin
	meta1 <= 1'b0; 
`ifdef RANDOM_INIT
	meta2 <= 1'b0; 
`endif
	q <= 1'b0; 
	end else begin
	meta1 <= d; 
`ifdef RANDOM_INIT
	meta2 <= c_meta2; 
`endif
	q <= c_q; 
	end
	end
endmodule 