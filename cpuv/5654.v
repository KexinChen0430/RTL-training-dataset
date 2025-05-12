module minimac_rxfifo(
	input sys_clk, 
	input rx_rst, 
	input phy_rx_clk, 
	input [3:0] phy_rx_data, 
	input phy_dv, 
	input phy_rx_er, 
	output empty, 
	input ack, 
	output eof, 
	output [7:0] data, 
	output reg fifo_full 
);
wire [8:0] fifo_out; 
assign eof = fifo_out[8]; 
assign data = fifo_out[7:0]; 
reg fifo_eof; 
reg [3:0] fifo_hi; 
reg [3:0] fifo_lo; 
wire [8:0] fifo_in = {fifo_eof, fifo_hi, fifo_lo}; 
reg fifo_we; 
wire full; 
minimac_asfifo_xilinx #(
	.DATA_WIDTH(9),
	.ADDRESS_WIDTH(7)
) fifo (
	.Data_out(fifo_out), 
	.Empty_out(empty), 
	.ReadEn_in(ack), 
	.RClk(sys_clk), 
	.Data_in(fifo_in), 
	.Full_out(full), 
	.WriteEn_in(fifo_we), 
	.WClk(phy_rx_clk), 
	.Clear_in(rx_rst) 
);
reg fifo_full1; 
always @(posedge sys_clk) begin
	fifo_full1 <= full; 
	fifo_full <= fifo_full1; 
end
reg rx_rst1; 
reg rx_rst2; 
always @(posedge phy_rx_clk) begin
	rx_rst1 <= rx_rst; 
	rx_rst2 <= rx_rst1; 
end
reg hi_nibble; 
reg abort; 
reg phy_dv_r; 
always @(posedge phy_rx_clk) begin
	if(rx_rst2) begin 
		fifo_we <= 1'b0;
		fifo_eof <= 1'b0;
		fifo_hi <= 4'd0;
		fifo_lo <= 4'd0;
		hi_nibble <= 1'b0;
		abort <= 1'b0;
		phy_dv_r <= 1'b0;
	end else begin 
		fifo_eof <= 1'b0;
		fifo_we <= 1'b0;
		if(~abort) begin 
			if(~hi_nibble) begin 
				fifo_lo <= phy_rx_data; 
				if(phy_dv) 
					hi_nibble <= 1'b1; 
			end else begin 
				fifo_hi <= phy_rx_data; 
				fifo_we <= 1'b1; 
				hi_nibble <= 1'b0; 
			end
		end
		if(phy_dv & phy_rx_er) begin 
			fifo_eof <= 1'b1;
			fifo_hi <= 4'd0;
			fifo_lo <= 4'd1;
			fifo_we <= 1'b1; 
			abort <= 1'b1; 
			hi_nibble <= 1'b0; 
		end
		phy_dv_r <= phy_dv; 
		if(phy_dv_r & ~phy_dv) begin 
			if(~abort) begin 
				fifo_eof <= 1'b1;
				fifo_hi <= 4'd0;
				fifo_lo <= 4'd0;
				fifo_we <= 1'b1; 
			end
			abort <= 1'b0; 
			hi_nibble <= 1'b0; 
		end
	end
end
endmodule 