module ac97_cra(clk, rst, 
		crac_we, crac_din, crac_out,
		crac_wr_done, crac_rd_done,
		valid, out_slt1, out_slt2,
		in_slt2,
		crac_valid, crac_wr
		);
input		clk, rst; 
input		crac_we; 
output	[15:0]	crac_din; 
input	[31:0]	crac_out; 
output		crac_wr_done, crac_rd_done; 
input		valid; 
output	[19:0]	out_slt1; 
output	[19:0]	out_slt2; 
input	[19:0]	in_slt2; 
output		crac_valid; 
output		crac_wr; 
reg		crac_wr; 
reg		crac_rd; 
reg		crac_rd_done; 
reg	[15:0]	crac_din; 
reg		crac_we_r; 
reg		valid_r; 
wire		valid_ne; 
wire		valid_pe; 
reg		rdd1, rdd2, rdd3; 
assign out_slt1[19]    = crac_out[31]; 
assign out_slt1[18:12] = crac_out[22:16]; 
assign out_slt1[11:0]  = 12'h0; 
assign out_slt2[19:4] = crac_out[15:0]; 
assign out_slt2[3:0] = 4'h0; 
always @(posedge clk or negedge rst) 
   begin
	if(!rst)		crac_din <= #1 16'h0; 
	else
	if(crac_rd_done)	crac_din <= #1 in_slt2[19:4]; 
   end
assign crac_valid = crac_wr | crac_rd; 
always @(posedge clk) 
	crac_we_r <= #1 crac_we; 
always @(posedge clk or negedge rst) 
	if(!rst)			crac_wr <= #1 1'b0; 
	else
	if(crac_we_r & !crac_out[31])	crac_wr <= #1 1'b1; 
	else
	if(valid_ne)			crac_wr <= #1 1'b0; 
assign crac_wr_done = crac_wr & valid_ne; 
always @(posedge clk or negedge rst) 
	if(!rst)			crac_rd <= #1 1'b0; 
	else
	if(crac_we_r & crac_out[31])	crac_rd <= #1 1'b1; 
	else
	if(rdd1 & valid_pe)		crac_rd <= #1 1'b0; 
always @(posedge clk or negedge rst) 
	if(!rst)			rdd1 <= #1 1'b0; 
	else
	if(crac_rd & valid_ne)		rdd1 <= #1 1'b1; 
	else
	if(!crac_rd)			rdd1 <= #1 1'b0; 
always @(posedge clk or negedge rst) 
	if(!rst)					rdd2 <= #1 1'b0; 
	else
	if( (crac_rd & valid_ne) | (!rdd3 & rdd2) )	rdd2 <= #1 1'b1; 
	else
	if(crac_rd_done)				rdd2 <= #1 1'b0; 
always @(posedge clk or negedge rst) 
	if(!rst)			rdd3 <= #1 1'b0; 
	else
	if(rdd2 & valid_pe)		rdd3 <= #1 1'b1; 
	else
	if(crac_rd_done)		rdd3 <= #1 1'b0; 
always @(posedge clk) 
	crac_rd_done <= #1 rdd3 & valid_pe; 
always @(posedge clk) 
	valid_r <= #1 valid; 
assign valid_ne = !valid & valid_r; 
assign valid_pe = valid & !valid_r; 
endmodule