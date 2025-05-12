module pal_sync_generator_progressive ( 
    input wire clk, 
	 input wire wssclk, 
	 input wire [2:0] ri, 
	 input wire [2:0] gi, 
	 input wire [2:0] bi, 
	 output wire [8:0] hcnt, 
	 output wire [8:0] vcnt, 
    output wire [2:0] ro, 
    output wire [2:0] go, 
    output wire [2:0] bo, 
    output wire csync 
    );
	reg [8:0] hc = 9'h000; 
	reg [8:0] vc = 9'h000; 
	reg [8:0] rhcnt = 332; 
	reg [8:0] rvcnt = 248; 
	assign hcnt = rhcnt; 
	assign vcnt = rvcnt; 
	always @(posedge clk) begin 
		if (rhcnt == `END_COUNT_H) begin 
			rhcnt <= 0; 
			if (rvcnt == `END_COUNT_V) 
				rvcnt <= 0; 
			else
				rvcnt <= rvcnt + 9'd1; 
		end
		else
			rhcnt <= rhcnt + 9'd1; 
	end
	always @(posedge clk) begin 
		if (hc == `END_COUNT_H) begin 
			hc <= 0; 
			if (vc == `END_COUNT_V) 
				vc <= 0; 
			else
				vc <= vc + 9'd1; 
		end
		else
			hc <= hc + 9'd1; 
	end
	reg rsync = 1; 
	reg in_visible_region = 1; 
	assign csync = rsync; 
	always @(posedge clk) begin 
	end
endmodule