module mem(
    input wire[31:0] memData_i,
    input wire[31:0] writeData_i,
    input wire[31:0] storeData_i,
    input wire[2:0] memOp_i,
    input wire insValid_i,
    input wire[31:0] insAddr_i,
    input wire inDelaySlot_i,
    input wire[3:0] exception_i,
    input wire[31:0] badVAddr_i,
    input wire[3:0] exceptionMC_i,
    input wire timeInt_i,
    input wire serialInt_i,
    input wire writeReg_i,
    input wire[4:0] writeRegAddr_i,
    input wire[31:0] writeDataHi_i,
    input wire[31:0] writeDataLo_i,
    input wire writeRegHiLo_i,
    input wire writeCP0_i,
    input wire[4:0] writeCP0Addr_i,
    input wire[31:0] cp0_Status_i,
    input wire[31:0] cp0_EntryHi_i,
    input wire[31:0] cp0_Ebase_i,
    input wire[31:0] cp0_EPC_i,
    output reg[2:0] memOp_o,
    output reg[31:0] storeData_o,
    output reg[31:0] memAddr_o,
    output reg writeReg_o,
    output reg[4:0] writeRegAddr_o,
    output reg[31:0] writeData_o,
    output reg[31:0] writeDataHi_o,
    output reg[31:0] writeDataLo_o,
    output reg writeRegHiLo_o,
    output reg writeCP0_o,
    output reg[4:0] writeCP0Addr_o,
    output reg flush_o,
    output reg[31:0] excAddr_o,
    output reg[3:0] exception_o,
    output reg inDelaySlot_o,
    output reg[31:0] insAddr_o,
    output reg[31:0] badVAddr_o
    );
    wire EXL = cp0_Status_i[`Status_EXL];
    wire ERL = cp0_Status_i[`Status_ERL];
    wire UM = cp0_Status_i[`Status_UM];
    wire BEV = cp0_Status_i[`Status_BEV];
    wire IE = cp0_Status_i[`Status_IE];
    wire[7:0] IM = cp0_Status_i[`Status_IM];
    wire isUserMode = (UM == 1'b1 && EXL == 1'b0 && ERL == 1'b0);
    wire[7:0] pendingInt = {timeInt_i, 2'h0, serialInt_i, 4'h0};
    wire[7:0] intVector = IM & pendingInt;
    wire isIntEnable = (IE == 1'b1 && EXL == 1'b0 && ERL == 1'b0 && (|intVector) == 1'b1 && insValid_i == `Enable);
    always @(*) begin
        inDelaySlot_o = inDelaySlot_i;
        insAddr_o = insAddr_i;
        writeRegAddr_o = writeRegAddr_i;
        writeDataHi_o = writeDataHi_i;
        writeDataLo_o = writeDataLo_i;
        writeCP0Addr_o = writeCP0Addr_i;
    end
    reg[3:0] preException;
    always @(*) begin
        if (isIntEnable == `Enable) begin
            preException = `EXC_INT;
        end else if (isUserMode == `Enable && (exception_i == `EXC_ERET || exception_i == `EXC_TLBWI || exception_i == `EXC_MC0)) begin
            preException = `EXC_CPU;
        end else begin
            preException = exception_i;
        end
    end
    reg[2:0] memOp;
    always @(*) begin
        if (preException == `EXC_NONE) begin
            memOp = memOp_i;
        end else begin
            memOp = `MEM_NOP_OP;
        end
    end
    wire[31:0] signData = {{24{memData_i[7]}}, memData_i[7:0]};
    wire[31:0] zeroData = {24'h0, memData_i[7:0]};
    reg[31:0] writeData;
    always @(*) begin
            memOp_o = memOp;
            storeData_o = `ZeroWord;
            memAddr_o = `ZeroWord;
            writeData = `ZeroWord;
        case (memOp)
            `MEM_NOP_OP: begin
                    writeData = writeData_i;
            end
            `MEM_LB_OP: begin
                    memAddr_o = writeData_i;
                    writeData = signData;
            end
            `MEM_LBU_OP: begin
                    memAddr_o = writeData_i;
                    writeData = zeroData;
            end
            `MEM_LW_OP: begin
                    memAddr_o = writeData_i;
                    writeData = memData_i;
            end
            `MEM_SB_OP: begin
                    storeData_o = storeData_i;
                    memAddr_o = writeData_i;
            end
            `MEM_SW_OP: begin
                    storeData_o = storeData_i;
                    memAddr_o = writeData_i;
            end
            default: begin
            end
        endcase
    end
    always @(*) begin
        if (preException != `EXC_NONE) begin
            exception_o = preException;
            badVAddr_o = badVAddr_i;
        end else begin
            exception_o = exceptionMC_i;
            badVAddr_o = writeData_i;
        end
    end
    always @(*) begin
        if (exception_o == `EXC_NONE || exception_o == `EXC_MC0 || exception_o == `EXC_TLBWI) begin
                writeReg_o = writeReg_i;
                writeData_o = writeData;
                writeRegHiLo_o = writeRegHiLo_i;
                writeCP0_o = writeCP0_i;
                flush_o = `Disable;
                excAddr_o = `ZeroWord;
        end else begin
                writeReg_o = `Disable;
                writeData_o = {24'h0, intVector};
                writeRegHiLo_o = `Disable;
                writeCP0_o = `Disable;
                flush_o = `Enable;
                if (exception_o == `EXC_ERET) begin
                    excAddr_o = cp0_EPC_i;
                end else begin
                    excAddr_o = cp0_Ebase_i;
                end
        end
    end
endmodule