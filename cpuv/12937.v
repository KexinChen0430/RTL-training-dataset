module id_ex (
    input wire 				clk, 
    input wire				rst, 
    input wire[`AluOpBus]	id_aluop, 
    input wire[`AluSelBus]	id_alusel, 
    input wire[`RegBus]		id_reg1, 
    input wire[`RegBus]		id_reg2, 
    input wire[`RegAddrBus]	id_waddr, 
    input wire				id_we, 
    input wire[5:0]			stall, 
    input wire 				flush, 
    input wire[`RegBus]		id_link_address, 
    input wire 				id_is_in_delayslot, 
    input wire 				next_inst_in_delayslot_i, 
    input wire[`RegBus]		id_inst, 
    input wire[`RegBus]		id_excepttype, 
    input wire[`RegBus]		id_current_inst_addr, 
    input wire 				id_current_inst_loaded, 
    output reg[`AluOpBus]	ex_aluop, 
    output reg[`AluSelBus]	ex_alusel, 
    output reg[`RegBus]		ex_reg1, 
    output reg[`RegBus]		ex_reg2, 
    output reg[`RegAddrBus] ex_waddr, 
    output reg 				ex_we, 
    output reg[`RegBus]		ex_link_address, 
    output reg 				ex_is_in_delayslot, 
    output reg 				is_delayslot_o, 
    output reg[`RegBus]		ex_inst, 
    output reg[`RegBus]		ex_excepttype, 
    output reg[`RegBus]		ex_current_inst_addr, 
    output reg 				ex_current_inst_loaded 
);
    always @(posedge clk) begin 
        if (rst == `RstEnable) begin 
        end
        else if (flush == `Flush) begin 
        end
        else if (stall[2] == `StallEnable && stall[3] == `StallDisable) begin 
        end
        else if (stall[2] == `StallDisable) begin 
        end
    end
endmodule