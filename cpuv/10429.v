module mem_wb( 
    input wire clk, 
    input wire rst, 
    input wire writeReg_i, 
    input wire[4:0] writeRegAddr_i, 
    input wire[31:0] writeData_i, 
    input wire[31:0] writeDataHi_i, 
    input wire[31:0] writeDataLo_i, 
    input wire writeRegHiLo_i, 
    input wire writeCP0_i, 
    input wire[4:0] writeCP0Addr_i, 
    input wire pauseControl_i, 
    input wire[3:0] exception_i, 
    input wire[31:0] insAddr_i, 
    input wire[31:0] badVAddr_i, 
    input wire inDelaySlot_i, 
    output reg writeReg_o, 
    output reg[4:0] writeRegAddr_o, 
    output reg[31:0] writeData_o, 
    output reg[31:0] writeDataHi_o, 
    output reg[31:0] writeDataLo_o, 
    output reg writeRegHiLo_o, 
    output reg writeCP0_o, 
    output reg[4:0] writeCP0Addr_o, 
    output reg[3:0] exception_o, 
    output reg[31:0] insAddr_o, 
    output reg[31:0] badVAddr_o, 
    output reg inDelaySlot_o 
    );
    wire writeReg = writeReg_o; 
    wire[4:0] writeRegAddr = writeRegAddr_o; 
    wire[31:0] writeData = writeData_o; 
    wire[31:0] writeDataHi = writeDataHi_o; 
    wire[31:0] writeDataLo = writeDataLo_o; 
    wire writeRegHiLo = writeRegHiLo_o; 
    wire writeCP0 = writeCP0_o; 
    wire[4:0] writeCP0Addr = writeCP0Addr_o; 
    wire[3:0] exception = exception_o; 
    wire[31:0] insAddr = insAddr_o; 
    wire[31:0] badVAddr = badVAddr_o; 
    wire inDelaySlot = inDelaySlot_o; 
    always @(posedge clk) begin 
        if (rst == `Enable) begin 
                writeReg_o <= `Disable; 
                writeRegAddr_o <= `ZeroWord; 
                writeData_o <= `ZeroWord; 
                writeDataHi_o <= `ZeroWord; 
                writeDataLo_o <= `ZeroWord; 
                writeRegHiLo_o <= `Disable; 
                writeCP0_o <= `Disable; 
                writeCP0Addr_o <= `CP0_NoAddr; 
                exception_o <= `EXC_NONE; 
                insAddr_o <= `ZeroWord; 
                badVAddr_o <= `ZeroWord; 
                inDelaySlot_o <= `Disable; 
        end else if (pauseControl_i == `PAUSE_CONTROLED) begin 
                writeReg_o <= writeReg; 
                writeRegAddr_o <= writeRegAddr; 
                writeData_o <= writeData; 
                writeDataHi_o <= writeDataHi; 
                writeDataLo_o <= writeDataLo; 
                writeRegHiLo_o <= writeRegHiLo; 
                writeCP0_o <= writeCP0; 
                writeCP0Addr_o <= writeCP0Addr; 
                exception_o <= exception; 
                insAddr_o <= insAddr; 
                badVAddr_o <= badVAddr; 
                inDelaySlot_o <= inDelaySlot; 
        end else begin 
                writeReg_o <= writeReg_i; 
                writeRegAddr_o <= writeRegAddr_i; 
                writeData_o <= writeData_i; 
                writeDataHi_o <= writeDataHi_i; 
                writeDataLo_o <= writeDataLo_i; 
                writeRegHiLo_o <= writeRegHiLo_i; 
                writeCP0_o <= writeCP0_i; 
                writeCP0Addr_o <= writeCP0Addr_i; 
                exception_o <= exception_i; 
                insAddr_o <= insAddr_i; 
                badVAddr_o <= badVAddr_i; 
                inDelaySlot_o <= inDelaySlot_i; 
        end
    end
endmodule 