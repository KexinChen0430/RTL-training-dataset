module sync_pedge_1 ( clk, d, pulse ); 
	input clk; 
	input d; 
	output pulse; 
	reg pulse; 
	reg q; 
	reg c_q; 
	reg  meta1; 
	reg  meta2; 
	reg c_meta2; 
`ifdef RANDOM_INIT
	reg meta3; 
	reg c_meta3; 
	reg rnd1, rnd2, in_change; 
`endif
	always @ (meta1 or meta2 or q
`ifdef RANDOM_INIT
	or d or meta3
`endif
	) begin
	pulse = ~q & meta2; 
	c_q = meta2; 
	c_meta2 = meta1; 
`ifdef RANDOM_INIT
	pulse = ~q & meta3; 
	in_change = (d & ~(meta1 | meta2 | meta3)) |
	(~d & (meta1 & meta2 & meta3)); 
	c_meta2 = meta1; 
	c_meta3 = meta2; 
	c_q = meta3; 
	if (in_change)
	begin
	rnd1 = $random(seed); 
	rnd2 = $random(seed); 
	c_meta3 = (~in_change & meta2) | (in_change & (d ^ (rnd1 | rnd2)
	)); 
	c_meta2 = (~in_change & meta1) | (in_change & (d ^ rnd1)); 
	end
`endif
	end
	always @(posedge clk) begin
	meta1 <= d; 
	meta2 <= c_meta2; 
`ifdef RANDOM_INIT
	meta3 <= c_meta3; 
`endif
	q <= c_q; 
	end
endmodule