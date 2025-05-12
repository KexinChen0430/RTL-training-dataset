module fifo_checksum #(
	parameter DATA_W = 1,
	parameter ONECLOCK = 1,
  	parameter EXTERNALLY_OUTPUT_REGISTERED = 0,
	parameter ERROR_SHIFT_BITS = 4
) (
	input wr_reset,
	input rd_reset,
	input wr_clk,
	input wr_en,
	input wr_full,
	input [DATA_W-1:0] wr_data,
	input rd_clk,
	input rd_en,
	input rd_empty,
	input [DATA_W-1:0] rd_data,
	`DEBUG_KEEP output reg checksum_error
);
localparam CHECKSUM_W = (DATA_W<16) ? (DATA_W+1)/2 : 4;
reg [CHECKSUM_W-1:0] wr_checksum;
always @(posedge wr_clk) begin
	if ((wr_en==1'b1) && (wr_full==1'b0)) begin
		wr_checksum <= wr_checksum ^ wr_data ^ (wr_data >> CHECKSUM_W);
	end
	if (wr_reset ) begin
		wr_checksum <= 'b0;
	end
end
reg [CHECKSUM_W-1:0] rd_checksum;
always @(posedge rd_clk) begin
	if ((rd_en==1'b1) && (rd_empty==1'b0)) begin
		rd_checksum <= rd_checksum ^ rd_data ^ (rd_data >> CHECKSUM_W);
	end
	if (rd_reset) begin
		rd_checksum <= 'b0;
	end
end
reg error_shift;
reg [ERROR_SHIFT_BITS-1:0] error_counter;
always @(posedge rd_clk) begin
	if (
`ifdef USE_SYNC_FIFO_CHECKSUM
`else
			ONECLOCK |
`endif
			EXTERNALLY_OUTPUT_REGISTERED) begin
	end else begin
		error_shift <= 1'b0;
		if (rd_empty==1'b1) begin
			if (rd_checksum != wr_checksum) begin
				error_shift <= 1'b1;
			end
		end
		if (error_shift==1'b1)
				error_counter <= error_counter+1'b1;
		else
				error_counter <= 1'b0;
		if (&error_counter) begin
			$display("ERROR: %m fifo checksums don't match: %x != %x\n",wr_checksum, rd_checksum);
			$stop;
			checksum_error <= 1'b1;
		end
		if (rd_reset) begin
			checksum_error <= 1'b0;
			error_shift <= 'b0;
			error_counter <= 'b0;
		end
	end
end
endmodule