module in_fsm_(
	clk,
	rst_a,
	ena,
	ready,
	src,
	snk  
);
`define BUS_SIZE 8
input clk;
input rst_a;
input ena;
output ready;
input [`BUS_SIZE-1:0] src;
output snk;
endmodule