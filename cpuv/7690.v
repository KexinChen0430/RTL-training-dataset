module parameterized_RAM #(
parameter SIZE = 10,
parameter LOOP = 2,
parameter NXT_LOOP = 5
)(
input clk_i,
input rd_i,
input wr_i,
input [7:0] data_i,
output reg [7:0] data_o = 0,
output wire ram_full_o,
output wire data_available_o
);
reg [7:0] RAM [SIZE*LOOP*2 - 1'b1: 0];
reg [$clog2(SIZE*LOOP*2 - 1'b1) - 1'b1:0] rd_addr = 0;
reg [$clog2(SIZE*LOOP*2 - 1'b1) - 1'b1:0] wr_addr = 0;
reg [$clog2(NXT_LOOP + 1) - 1'b1:0] loop_cnt = 0;
reg [1:0] sector_written = 0;
assign data_available_o = sector_written[0] | sector_written[1];
assign ram_full_o = sector_written[0] & sector_written[1];
integer i;
initial begin
	for(i = 0; i < SIZE*LOOP*2; i = i + 1) begin
		RAM[i] = 0;
	end
end
always@(posedge clk_i) begin
	data_o <= RAM[rd_addr];
	if (wr_i) begin
		wr_addr <= wr_addr + 1'b1;
		RAM[wr_addr] <= data_i;
	end
	if(wr_addr == SIZE*LOOP - 1)
		sector_written[0] <= 1;
	else if(wr_addr == SIZE*LOOP*2 - 1) begin
		sector_written[1] <= 1;
		wr_addr <= 0;
	end
	if (rd_i) begin
		rd_addr <= rd_addr + 1'b1;
	end
	if (rd_addr == SIZE*LOOP - 1 || rd_addr == SIZE*LOOP*2 - 1) begin
		loop_cnt <= loop_cnt + 1'b1;
		if(rd_addr == SIZE*LOOP - 1)
			rd_addr <= 0;
		else if(rd_addr == SIZE*LOOP*2 - 1)
			rd_addr <= SIZE*LOOP;
		if(loop_cnt == NXT_LOOP - 1) begin
			loop_cnt <= 0;
			if(rd_addr == SIZE*LOOP - 1) begin
				sector_written[0] <= 0;
				rd_addr <= SIZE*LOOP;
			end
			else if(rd_addr == SIZE*LOOP*2 - 1) begin
				sector_written[1] <= 0;
				rd_addr <= 0;
			end
		end
	end
end
endmodule