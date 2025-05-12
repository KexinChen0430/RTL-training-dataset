module minimac_ctlif #(
	parameter csr_addr = 4'h0 
) (
	input sys_clk, 
	input sys_rst, 
	input [13:0] csr_a, 
	input csr_we, 
	input [31:0] csr_di, 
	output reg [31:0] csr_do, 
	output reg irq_rx, 
	output reg irq_tx, 
	output reg rx_rst, 
	output reg tx_rst, 
	output rx_valid, 
	output [29:0] rx_adr, 
	input rx_resetcount, 
	input rx_incrcount, 
	input rx_endframe, 
	input fifo_full, 
	output tx_valid, 
	output reg [29:0] tx_adr, 
	output reg [1:0] tx_bytecount, 
	input tx_next, 
	output reg phy_mii_clk, 
	inout phy_mii_data 
);
reg mii_data_oe; 
reg mii_data_do; 
assign phy_mii_data = mii_data_oe ? mii_data_do : 1'bz;
reg mii_data_di1; 
reg mii_data_di; 
always @(posedge sys_clk) begin
	mii_data_di1 <= phy_mii_data;
	mii_data_di <= mii_data_di1;
end
reg [1:0] slot0_state;
reg [29:0] slot0_adr;
reg [10:0] slot0_count;
reg [1:0] slot1_state;
reg [29:0] slot1_adr;
reg [10:0] slot1_count;
reg [1:0] slot2_state;
reg [29:0] slot2_adr;
reg [10:0] slot2_count;
reg [1:0] slot3_state;
reg [29:0] slot3_adr;
reg [10:0] slot3_count;
wire select0 = slot0_state[0];
wire select1 = slot1_state[0] & ~slot0_state[0];
wire select2 = slot2_state[0] & ~slot1_state[0] & ~slot0_state[0];
wire select3 = slot3_state[0] & ~slot2_state[0] & ~slot1_state[0] & ~slot0_state[0];
assign rx_valid = slot0_state[0] | slot1_state[0] | slot2_state[0] | slot3_state[0];
assign rx_adr =  {30{select0}} & slot0_adr
		|{30{select1}} & slot1_adr
		|{30{select2}} & slot2_adr
		|{30{select3}} & slot3_adr;
reg [10:0] tx_remaining;
assign tx_valid = |tx_remaining;
wire csr_selected = csr_a[13:10] == csr_addr;
always @(posedge sys_clk) begin
	if(sys_rst) begin
		csr_do <= 32'd0;
		rx_rst <= 1'b1;
		tx_rst <= 1'b1;
		mii_data_oe <= 1'b0;
		mii_data_do <= 1'b0;
		phy_mii_clk <= 1'b0;
		slot0_state <= 2'b00;
		slot0_adr <= 30'd0;
		slot0_count <= 11'd0;
		slot1_state <= 2'b00;
		slot1_adr <= 30'd0;
		slot1_count <= 11'd0;
		slot2_state <= 2'b00;
		slot2_adr <= 30'd0;
		slot2_count <= 11'd0;
		slot3_state <= 2'b00;
		slot3_adr <= 30'd0;
		slot3_count <= 11'd0;
		tx_remaining <= 11'd0;
		tx_adr <= 30'd0;
		tx_bytecount <= 2'd0;
	end else begin
		csr_do <= 32'd0;
		if(csr_selected) begin
			if(csr_we) begin
				case(csr_a[3:0])
				endcase
			end
			case(csr_a[3:0])
			endcase
		end
	end
end
always @(posedge sys_clk) begin
	if(sys_rst) begin
		irq_rx <= 1'b0;
		tx_valid_r <= 1'b0;
		irq_tx <= 1'b0;
	end else begin
		irq_rx <= slot0_state[1] | slot1_state[1] | slot2_state[1] | slot3_state[1] | fifo_full;
		tx_valid_r <= tx_valid;
		irq_tx <= tx_valid_r & ~tx_valid;
	end
end
endmodule