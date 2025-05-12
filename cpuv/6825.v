module interpreter(
	input wire mclk,
	input wire stall,
	output reg[31:0] mem_address,
	output reg[31:0] mem_din,
	input wire[31:0] mem_dout,
	output reg mem_re = 0,
	output reg mem_we = 0
);
initial begin
	mem_address = 32'h0;
end
endmodule