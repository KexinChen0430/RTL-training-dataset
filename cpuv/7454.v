module Memory(
	input wire [31:0] wData,
	input wire clk,
	input wire enable,
	input wire rw,
	input wire reset,
	input wire [9:0] add,
	output reg [31:0] rData
);
	reg [31:0] mem [1023:0];
	integer i;
	always @(posedge clk) begin
		if (reset) begin
			for(i = 0; i < 1024; i = i + 1) begin
				mem[i] = 32'h00000000;
			end
			rData = 32'h00000000;
			mem[0] = 32'h68100000;
			mem[1] = 32'hC00;
			mem[2] = 32'h80000800;
			mem[3] = 32'h80000800;
			mem[4] = 32'h80000800;
			mem[5] = 32'h800;
			mem[6] = 32'h80;
			mem[7] = 32'h0;
			mem[8] = 32'h59002000;
			mem[9] = 32'h59804000;
			mem[10] = 32'h5A006000;
			mem[11] = 32'h5A808000;
			mem[12] = 32'h5B00A000;
			mem[13] = 32'h5B80C000;
			mem[14] = 32'h7AB02400;
			mem[15] = 32'h1DBD8000;
			mem[16] = 32'h6580E000;
			mem[17] = 32'h68340000;
			mem[18] = 32'h1AAC0000;
			mem[19] = 32'h19440000;
			mem[20] = 32'h19AC8000;
			mem[21] = 32'hC4D0000;
			mem[22] = 32'hD250000;
			mem[23] = 32'hDD58000;
			mem[24] = 32'hABA8000;
			mem[25] = 32'h681C0000;
		end
		else begin
			if (enable) begin
				if (!rw) rData = mem[add];
				else mem[add] = wData;
			end
		end
	end
endmodule