module log2_table
	(
	input	     	clk,			
	input		trilinear_en, 		
	input	[31:0]	val, 			
	output	[9:0]	log2			
	);
	reg	[3:0]	int_mm_no;		
	reg	[5:0]	lod_fract;		
	wire		 over_flow;		
	wire	[9:0]	 log_in;		
	assign log_in = val[17:8];		
	assign over_flow = |val[31:18];	
	always @(posedge clk) begin
		casex ({over_flow, log_in})
		endcase
	end
	assign log2 = {int_mm_no, lod_fract};
endmodule