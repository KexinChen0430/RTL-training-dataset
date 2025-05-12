module CPU_Test; 
reg clk; 
reg clk_click; 
reg rst; 
wire [15:0] PC_out; 
wire [15:0] IR_out; 
wire [15:0] b16_out; 
wire [15:0] LED_datmem; 
wire [7:0] LED_out; 
wire [5:0] LED_ctrl; 
wire [2:0] state; 
wire [5:0] cur_ins; 
CPU_MIPS uut (
	.PC_out(PC_out), 
	.IR_out(IR_out), 
	.b16_out(b16_out), 
	.LED_datmem(LED_datmem), 
	.LED_out(LED_out), 
	.LED_ctrl(LED_ctrl), 
	.clk(clk), 
	.clk_click(clk_click), 
	.rst(rst), 
	.real_clk(real_clk), 
	.state(state), 
	.cur_ins(cur_ins) 
);
initial begin 
	clk = 0; 
	rst = 0; 
	#100; 
	rst = 1; 
end
always begin 
	clk = 0; 
	#1; 
	clk = 1; 
	#1; 
end
endmodule 