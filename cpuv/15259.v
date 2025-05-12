module ex_mem ( 
	input wire					rst, 
	input wire					clk, 
	input wire[`RegAddrBus]		ex_waddr, 
	input wire					ex_we, 
	input wire[`RegBus]			ex_wdata, 
	input wire 					ex_whilo, 
	input wire[`RegBus]			ex_hi, 
	input wire[`RegBus]			ex_lo, 
	input wire[5:0]				stall, 
	input wire[`DoubleRegBus]	hilo_i, 
	input wire[1:0]				cnt_i, 
	input wire[`AluOpBus]		ex_aluop, 
	input wire[`RegBus]			ex_mem_addr, 
	input wire[`RegBus]			ex_reg2, 
	input wire[`RegBus]			ex_cp0_reg_data, 
	input wire[`RegAddrBus]		ex_cp0_reg_waddr, 
	input wire 					ex_cp0_reg_we, 
	input wire 					flush, 
	input wire[`RegBus]			ex_excepttype, 
	input wire[`RegBus]			ex_current_inst_addr, 
	input wire 					ex_current_inst_loaded, 
	input wire 					ex_is_in_delayslot, 
	output reg[`RegAddrBus]		mem_waddr, 
	output reg 					mem_we, 
	output reg[`RegBus]			mem_wdata, 
	output reg 					mem_whilo, 
	output reg[`RegBus]			mem_hi, 
	output reg[`RegBus]			mem_lo, 
	output reg[`DoubleRegBus]	hilo_o, 
	output reg[1:0]				cnt_o, 
	output reg[`AluOpBus]		mem_aluop, 
	output reg[`RegBus]			mem_mem_addr, 
	output reg[`RegBus]			mem_reg2, 
	output reg[`RegBus]			mem_cp0_reg_data, 
	output reg[`RegAddrBus]		mem_cp0_reg_waddr, 
	output reg 					mem_cp0_reg_we, 
	output reg[`RegBus]			mem_excepttype, 
	output reg[`RegBus]			mem_current_inst_addr, 
	output reg 					mem_current_inst_loaded, 
	output reg 					mem_is_in_delayslot 
);
	always @(posedge clk) begin 
		if (rst == `RstEnable) begin 
		end
		else if (flush == `Flush) begin 
		end
		else if (stall[3] == `StallEnable && stall[4] == `StallDisable) begin 
		end
		else if (stall[3] == `StallDisable) begin 
		end
		else begin
		end
	end
endmodule