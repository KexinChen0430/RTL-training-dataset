module rom (
	input  wire				   clk,		
	input  wire				   reset,	
	input  wire				   cs_,		
	input  wire				   as_,		
	input  wire [`RomAddrBus]  addr,	
	output wire [`WordDataBus] rd_data, 
	output reg				   rdy_		
);
	x_s3e_sprom x_s3e_sprom (
		.clka  (clk),					
		.addra (addr),					
		.douta (rd_data)				
	);
	always @(posedge clk or `RESET_EDGE reset) begin
		if (reset == `RESET_ENABLE) begin
			rdy_ <= #1 `DISABLE_;
		end else begin
			if ((cs_ == `ENABLE_) && (as_ == `ENABLE_)) begin
				rdy_ <= #1 `ENABLE_;
			end else begin
				rdy_ <= #1 `DISABLE_;
			end
		end
	end
endmodule