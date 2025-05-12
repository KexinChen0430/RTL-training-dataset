module resetter(
	clk,
	rst_in_n,
	rst_out_n );
parameter RST_CNT_SIZE = 4; 
input clk; 
input rst_in_n; 
output rst_out_n; 
reg    rst_out_n; 
reg [RST_CNT_SIZE:0] rst_cnt; 
reg rst1_n,rst2_n; 
`ifdef SIMULATE 
	initial 
	begin
		rst_cnt = 0; 
		rst1_n = 1'b0; 
		rst2_n = 1'b0; 
		rst_out_n = 1'b0; 
	end
`endif
	always @(posedge clk, negedge rst_in_n) 
	if( !rst_in_n ) 
	begin
		rst_cnt <= 0; 
		rst1_n <= 1'b0; 
		rst2_n <= 1'b0; 
		rst_out_n <= 1'b0; 
	end
	else 
	begin
		rst1_n <= 1'b1; 
		rst2_n <= rst1_n; 
		if( rst2_n && !rst_cnt[RST_CNT_SIZE] ) 
		begin
			rst_cnt <= rst_cnt + 1; 
		end
		if( rst_cnt[RST_CNT_SIZE] ) 
		begin
			rst_out_n <= 1'b1; 
		end
	end
endmodule