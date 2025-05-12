module ex_mem(
    input wire clk, 
    input wire rst, 
    input wire[31:0] writeData_i, 
    input wire[31:0] insAddr_i, 
    input wire[31:0] storeData_i, 
    input wire[2:0] memOp_i, 
    input wire writeReg_i, 
    input wire[4:0] writeRegAddr_i, 
    input wire[31:0] writeDataHi_i, 
    input wire[31:0] writeDataLo_i, 
    input wire writeRegHiLo_i, 
    input wire writeCP0_i, 
    input wire[4:0] writeCP0Addr_i, 
    input wire insValid_i, 
    input wire inDelaySlot_i, 
    input wire[3:0] exception_i, 
    input wire[31:0] badVAddr_i, 
    input wire pauseControl_i, 
    input wire flush_i, 
    output reg[31:0] writeData_o, 
    output reg[31:0] insAddr_o, 
    output reg[31:0] storeData_o, 
    output reg[2:0] memOp_o, 
    output reg writeReg_o, 
    output reg[4:0] writeRegAddr_o, 
    output reg[31:0] writeDataHi_o, 
    output reg[31:0] writeDataLo_o, 
    output reg writeRegHiLo_o, 
    output reg writeCP0_o, 
    output reg[4:0] writeCP0Addr_o, 
    output reg insValid_o, 
    output reg inDelaySlot_o, 
    output reg[3:0] exception_o, 
    output reg[31:0] badVAddr_o 
);
wire[31:0] writeData = writeData_o;
wire[31:0] insAddr = insAddr_o;
wire[31:0] storeData = storeData_o;
wire[2:0] ramOp = memOp_o;
wire writeReg = writeReg_o;
wire[4:0] writeRegAddr = writeRegAddr_o;
wire[31:0] writeDataHi = writeDataHi_o;
wire[31:0] writeDataLo = writeDataLo_o;
wire writeRegHiLo = writeRegHiLo_o;
wire writeCP0 = writeCP0_o;
wire[4:0] writeCP0Addr = writeCP0Addr_o;
wire insValid = insValid_o;
wire inDelaySlot = inDelaySlot_o;
wire[3:0] exception = exception_o;
wire[31:0] badVAddr = badVAddr_o;
always @(posedge clk) begin
    if (rst == `Enable) begin 
        writeData_o <= `ZeroWord;
        insAddr_o <= `ZeroWord;
        storeData_o <= `ZeroWord;
        memOp_o <= `MEM_NOP_OP;
        writeReg_o <= `Disable;
        writeRegAddr_o <= `ZeroWord;
        writeDataHi_o <= `ZeroWord;
        writeDataLo_o <= `ZeroWord;
        writeRegHiLo_o <= `Disable;
        writeCP0_o <= `Disable;
        writeCP0Addr_o <= `CP0_NoAddr;
        insValid_o <= `Disable;
        inDelaySlot_o <= `Disable;
        exception_o <= `EXC_NONE;
        badVAddr_o <= `ZeroWord;
    end else if (pauseControl_i == `PAUSE_CONTROLED) begin 
        writeData_o <= writeData;
        insAddr_o <= insAddr;
        storeData_o <= storeData;
        memOp_o <= ramOp;
        writeReg_o <= writeReg;
        writeRegAddr_o <= writeRegAddr;
        writeDataHi_o <= writeDataHi;
        writeDataLo_o <= writeDataLo;
        writeRegHiLo_o <= writeRegHiLo;
        writeCP0_o <= writeCP0;
        writeCP0Addr_o <= writeCP0Addr;
        insValid_o <= insValid;
        inDelaySlot_o <= inDelaySlot;
        exception_o <= exception;
        badVAddr_o <= badVAddr;
    end else if (flush_i == `Enable) begin 
        writeData_o <= `ZeroWord;
        insAddr_o <= `ZeroWord;
        storeData_o <= `ZeroWord;
        memOp_o <= `MEM_NOP_OP;
        writeReg_o <= `Disable;
        writeRegAddr_o <= `ZeroWord;
        writeDataHi_o <= `ZeroWord;
        writeDataLo_o <= `ZeroWord;
        writeRegHiLo_o <= `Disable;
        writeCP0_o <= `Disable;
        writeCP0Addr_o <= `CP0_NoAddr;
        insValid_o <= `Disable;
        inDelaySlot_o <= `Disable;
        exception_o <= `EXC_NONE;
        badVAddr_o <= `ZeroWord;
    end else begin 
        writeData_o <= writeData_i;
        insAddr_o <= insAddr_i;
        storeData_o <= storeData_i;
        memOp_o <= memOp_i;
        writeReg_o <= writeReg_i;
        writeRegAddr_o <= writeRegAddr_i;
        writeDataHi_o <= writeDataHi_i;
        writeDataLo_o <= writeDataLo_i;
        writeRegHiLo_o <= writeRegHiLo_i;
        writeCP0_o <= writeCP0_i;
        writeCP0Addr_o <= writeCP0Addr_i;
        insValid_o <= insValid_i;
        inDelaySlot_o <= inDelaySlot_i;
        exception_o <= exception_i;
        badVAddr_o <= badVAddr_i;
    end
end
endmodule