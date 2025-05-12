module scandoubler
(
	input            clk_sys, 
	input            ce_pix,  
	input            hs_in,   
	input            vs_in,   
	input      [5:0] r_in,    
	input      [5:0] g_in,    
	input      [5:0] b_in,    
	output reg       hs_out,  
	output           vs_out,  
	output reg [5:0] r_out,   
	output reg [5:0] g_out,   
	output reg [5:0] b_out    
);
assign vs_out = vs_in; 
reg ce_x1, ce_x2; 
always @(negedge clk_sys) begin 
	reg old_ce; 
	reg [7:0] cnt   = 0; 
	reg [7:0] pixsz = 0; 
	old_ce <= ce_pix; 
	if(~&cnt) cnt <= cnt + 1'd1; 
	ce_x2 <= 0; 
	ce_x1 <= 0; 
	if(~old_ce & ce_pix) begin 
		pixsz <= {1'b0, cnt[7:1]}; 
		ce_x1 <= 1; 
		ce_x2 <= 1; 
		cnt   <= 0; 
	end
	if(cnt == pixsz) ce_x2 <= 1; 
end
always @(posedge clk_sys) begin 
	(* ramstyle = "no_rw_check" *) reg [17:0] sd_buffer[2047:0]; 
	reg        line_toggle; 
	reg  [9:0] hs_max, hs_max_next; 
	reg  [9:0] hs_rise, hs_rise_next; 
	reg  [9:0] hcnt; 
	reg hs, hs2, vs; 
	reg [9:0] sd_hcnt; 
	if(ce_x1) begin 
		hs <= hs_in; 
		if(hs && !hs_in) begin 
			hs_max_next <= hcnt; 
			hcnt <= 0; 
		end else begin
			hcnt <= hcnt + 1'd1; 
		end
		if(!hs && hs_in) hs_rise_next <= hcnt; 
		vs <= vs_in; 
		if(vs != vs_in) line_toggle <= 0; 
		if(hs && !hs_in) line_toggle <= !line_toggle; 
		sd_buffer[{line_toggle, hcnt}] <= {r_in, g_in, b_in}; 
	end
	if(ce_x2) begin 
		hs2 <= hs_in; 
		sd_hcnt <= sd_hcnt + 1'd1; 
		if(hs2 && !hs_in) begin 
			hs_max  <= hs_max_next; 
			sd_hcnt <= hs_max_next; 
			hs_rise <= hs_rise_next; 
		end
		if(sd_hcnt == hs_max)  sd_hcnt <= 0; 
		if(sd_hcnt == hs_max)  hs_out  <= 0; 
		if(sd_hcnt == hs_rise) hs_out  <= 1; 
		{r_out, g_out, b_out}  <= sd_buffer[{~line_toggle, sd_hcnt}]; 
	end
end
endmodule