module PATTERN( 
	output reg       clk, 
	output reg [2:0] circle1, 
	output reg [2:0] circle2, 
	output reg [4:0] in, 
	output reg       in_valid, 
	output reg       rst_n, 
	input [5:0]      out, 
	input            out_valid 
);
reg [4:0] pixel1 [0:7]; 
reg [4:0] pixel2 [0:7]; 
parameter CLK = `CLK_PERIOD; 
parameter PATTERN_NUM = 10; 
integer latency, total_latency; 
integer pattern_num; 
integer round; 
integer i,j; 
integer op; 
integer ans[0:7]; 
integer unsort[0:7]; 
integer swap; 
integer cir1, cir2; 
initial begin 
	total_latency = 0; 
end
initial begin 
	clk = 0; 
	forever #CLK clk = ~clk; 
end
initial begin 
	in <= 'dx; 
	in_valid <= 'bx; 
	rst_n <= 1'b1; 
	#16; 
	rst_n <= 1'b0; 
	#8; 
	rst_n <= 1'b1; 
	check_out_rst; 
	check_out_valid_rst; 
	in_valid <= 'b0; 
	#16 
	@(negedge clk); 
	for(pattern_num=0;pattern_num<PATTERN_NUM;pattern_num=pattern_num+1) begin 
	end
end
task check_out_valid_rst; 
begin
end
endtask
task check_out_rst; 
begin
end
endtask
task wait_out; 
begin
end
endtask
task operate; 
begin
end
endtask
endmodule 