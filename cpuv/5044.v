module Terminal(
	dout,
	din,
	address,
	size,
	read_write,
	enable,
	interrupt,
	reset,
	clk
);
	`include "definition/Definition.v"
	output	wire		[WORD-1:0]								dout;
	input	wire		[WORD-1:0]								din;
	input	wire		[WORD-1:0]								address;
	input	wire		[LOGWORDBYTE-1:0]						size;
	input	wire												read_write;
	input	wire												enable;
	output	wire												interrupt;
	input														reset;
	input														clk;
	assign dout			= 0;
	assign interrupt	= 0;
endmodule