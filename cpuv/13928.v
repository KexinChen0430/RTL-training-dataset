module regfile( 
	input 							clk, 
	input 							rst, 
	input[`RegAddrWidth-1:0]		waddr, 
	input[`RegDataWidth-1:0]		wdata, 
	input							we, 
	input							re1, 
	input[`RegAddrWidth-1:0]		raddr_1, 
	output reg[`RegDataWidth-1:0]	rdata_1, 
	input							re2, 
	input[`RegAddrWidth-1:0]		raddr_2, 
	`ifdef DEBUG 
	output reg[`RegDataWidth-1:0]	rdata_2, 
	`endif
	`ifndef DEBUG 
	output reg[`RegDataWidth-1:0]	rdata_2 
	`endif
);
	reg[`RegDataWidth-1:0] regs[`RegNum-1:0]; 
	`ifdef DEBUG 
	`endif
	always @(posedge clk) begin : proc_reset 
		integer i;
		if (rst == `RstEnable) begin 
			for (i = 0; i < `RegNum; i = i + 1) 
				regs[i] <= 0; 
		end
	end
	always @(negedge clk) begin : proc_write 
		if (rst == ~`RstEnable) 
			if ((we == `WriteEnable) && (waddr != `RegAddrWidth'b0)) 
				regs[waddr] <= wdata; 
	end
	always @(*) begin : proc_read1 
		if (re1 == `ReadEnable && rst == ~`RstEnable) 
			rdata_1 <= regs[raddr_1]; 
		else
			rdata_1 <= `ZeroWord; 
	end
	always @(*) begin : proc_read2 
		if (re2 == `ReadEnable && rst == ~`RstEnable) 
			rdata_2 <= regs[raddr_2]; 
		else
			rdata_2 <= `ZeroWord; 
	end
endmodule 