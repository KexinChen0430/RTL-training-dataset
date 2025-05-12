module ac97_soc(clk, wclk, rst,
		ps_ce, resume, suspended,
		sync, out_le, in_valid, ld, valid
		); 
input		clk, wclk, rst; 
input		ps_ce; 
input		resume; 
output		suspended; 
output		sync; 
output	[5:0]	out_le; 
output	[2:0]	in_valid; 
output		ld; 
output		valid; 
reg	[7:0]	cnt; 
reg		sync_beat; 
reg		sync_resume; 
reg	[5:0]	out_le; 
reg		ld; 
reg		valid; 
reg	[2:0]	in_valid; 
reg		bit_clk_capture; 
reg		bit_clk_capture_r; 
reg		bit_clk_e; 
reg		suspended; 
wire		to; 
reg	[5:0]	to_cnt; 
reg	[3:0]	res_cnt; 
wire		resume_done; 
assign sync = sync_beat | sync_resume; 
always @(posedge clk or negedge rst) 
	if(!rst)		cnt <= #1 8'hff; 
	else
	if(suspended)		cnt <= #1 8'hff; 
	else			cnt <= #1 cnt + 8'h1; 
always @(posedge clk) 
	ld <= #1 (cnt == 8'h00); 
always @(posedge clk) 
	sync_beat <= #1 (cnt == 8'h00) | ((cnt > 8'h00) & (cnt < 8'h10)); 
always @(posedge clk) 
	valid <= #1 (cnt > 8'h39); 
always @(posedge clk) 
	out_le[0] <= #1 (cnt == 8'h11);		
always @(posedge clk) 
	out_le[1] <= #1 (cnt == 8'h25);		
always @(posedge clk) 
	out_le[2] <= #1 (cnt == 8'h39);		
always @(posedge clk) 
	out_le[3] <= #1 (cnt == 8'h4d);		
always @(posedge clk) 
	out_le[4] <= #1 (cnt == 8'h61);		
always @(posedge clk) 
	out_le[5] <= #1 (cnt == 8'h89);		
always @(posedge clk) 
	in_valid[0] <= #1 (cnt > 8'h4d);	
always @(posedge clk) 
	in_valid[1] <= #1 (cnt > 8'h61);	
always @(posedge clk) 
	in_valid[2] <= #1 (cnt > 8'h89);	
always @(clk or bit_clk_e) 
	if(clk)			bit_clk_capture <= #1 1'b1; 
	else
	if(bit_clk_e)		bit_clk_capture <= #1 1'b0; 
always @(posedge wclk) 
	bit_clk_capture_r <= #1 bit_clk_capture; 
always @(posedge wclk) 
	bit_clk_e <= #1 bit_clk_capture_r; 
always @(posedge wclk) 
	suspended <= #1 to; 
assign to = (to_cnt == `AC97_SUSP_DET); 
always @(posedge wclk or negedge rst) 
	if(!rst)		to_cnt <= #1 6'h0; 
	else
	if(bit_clk_e)		to_cnt <= #1 6'h0; 
	else
	if(!to)			to_cnt <= #1 to_cnt + 6'h1; 
always @(posedge wclk or negedge rst) 
	if(!rst)			sync_resume <= #1 1'b0; 
	else
	if(resume_done)			sync_resume <= #1 1'b0; 
	else
	if(suspended & resume)		sync_resume <= #1 1'b1; 
assign resume_done = (res_cnt == `AC97_RES_SIG); 
always @(posedge wclk) 
	if(!sync_resume)	res_cnt <= #1 4'h0; 
	else
	if(ps_ce)		res_cnt <= #1 res_cnt + 4'h1; 
endmodule 