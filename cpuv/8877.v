module block_ram #(
	parameter ADDR_WIDTH	= 16,
	parameter DATA_WIDTH	= 8,
	parameter MEM_BYTES		= 1024,
) (
	input							clk,
	input	   [ADDR_WIDTH - 1 : 0]	addr0,
	output reg [DATA_WIDTH - 1 : 0]	rd_data0,
	input	   [DATA_WIDTH - 1 : 0]	wr_data0,
	input							wr0,
	input	   [ADDR_WIDTH - 1 : 0]	addr1,
	output reg [DATA_WIDTH - 1 : 0]	rd_data1,
);
	reg [DATA_WIDTH - 1 : 0] mem [MEM_BYTES - 1 : 0];
	integer i;
	initial begin
		for (i = 0; i < MEM_BYTES; i++) begin
			mem[i] <= 0;
		end
	end
	always @(posedge clk) begin
		if (wr0) begin
			mem[addr0] <= wr_data0;
		end
		rd_data0 <= mem[addr0];
		rd_data1 <= mem[addr1];
	end
endmodule