module k580vi53
(
	input        reset, 
	input        clk_sys, 
	input  [1:0] addr, 
	input  [7:0] din, 
	output [7:0] dout, 
	input        wr, 
	input        rd, 
	input  [2:0] clk_timer, 
	input  [2:0] gate, 
	output [2:0] out, 
	output [2:0] sound_active 
);
wire	[7:0] dout0; 
wire	[7:0]	dout1; 
wire	[7:0]	dout2; 
assign dout = dout0 & dout1 & dout2;
timer t0(reset, clk_sys, clk_timer[0], din, dout0, wr && (addr == 3) && (din[7:6] == 0), wr && (addr == 0), rd && (addr == 0), gate[0], out[0], sound_active[0]);
timer t1(reset, clk_sys, clk_timer[1], din, dout1, wr && (addr == 3) && (din[7:6] == 1), wr && (addr == 1), rd && (addr == 1), gate[1], out[1], sound_active[1]);
timer t2(reset, clk_sys, clk_timer[2], din, dout2, wr && (addr == 3) && (din[7:6] == 2), wr && (addr == 2), rd && (addr == 2), gate[2], out[2], sound_active[2]);
endmodule