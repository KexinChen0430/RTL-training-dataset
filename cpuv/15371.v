module memcontrol(
    input wire clk, 
    input wire rst, 
    input wire[2:0] ramOp_i, 
    input wire[31:0] storeData_i, 
    input wire[31:0] ramAddr_i, 
    input wire[31:0] insAddr_i, 
    input wire[31:0] ramData_i, 
    input wire[3:0] exception_i, 
    input wire pauseRequest_i, 
    output wire pauseRequest_o, 
    output reg[31:0] ramData_o, 
    output reg[31:0] ins_o, 
    output reg[2:0] ramOp_o, 
    output reg[31:0] storeData_o, 
    output reg[31:0] ramAddr_o, 
    output reg[3:0] exceptionMEM_o, 
    output reg[3:0] exceptionIF_o, 
    output reg[31:0] badVAddrIF_o 
);
reg[2:0] memState; 
reg[31:0] dataBuffer; 
reg[31:0] storeByteBuffer; 
reg[3:0] exceptionBuffer; 
reg pauseRequest; 
wire[31:0] ramAddrAligned = {ramAddr_i[31:2], 2'b00};
wire[2:0] memLastState = memState;
assign pauseRequest_o = pauseRequest | pauseRequest_i;
always @(posedge clk) begin
    if (rst == `Enable) begin 
        memState <= `S_IDLE;
    end else if (pauseRequest_i == `Enable) begin 
        memState <= memLastState;
    end else if (memState == `S_IDLE || memState == `S_DATA || memState == `S_SB_STORE) begin 
        memState <= `S_INST;
    end else if (memState == `S_SB_LOAD) begin 
        memState <= `S_SB_STORE;
    end else if (ramOp_i == `MEM_NOP_OP) begin 
        memState <= `S_INST;
    end else if (ramOp_i == `MEM_SB_OP) begin 
        memState <= `S_SB_LOAD;
    end else begin 
        memState <= `S_DATA;
    end
end
always @(posedge clk) begin
    if (rst == `Enable) begin 
        dataBuffer <= `ZeroWord;
        exceptionBuffer <= `EXC_NONE;
    end else if (memState == `S_INST) begin 
        dataBuffer <= ramData_i;
        exceptionBuffer <= exception_i;
    end
end
always @(*) begin
    if (exceptionIF_o != `EXC_NONE) begin 
        badVAddrIF_o = insAddr_i;
    end else begin 
        badVAddrIF_o = `ZeroWord;
    end
end
always @(posedge clk) begin
    if (rst == `Enable) begin 
        storeByteBuffer <= `ZeroWord;
    end else if (memState == `S_SB_LOAD) begin 
        if (ramAddr_i[1:0] == 2'b11) begin
            storeByteBuffer <= {storeData_i[7:0], ramData_i[23:0]};
        end else if (ramAddr_i[1:0] == 2'b10) begin
            storeByteBuffer <= {ramData_i[31:24], storeData_i[7:0], ramData_i[15:0]};
        end else if (ramAddr_i[1:0] == 2'b01) begin
            storeByteBuffer <= {ramData_i[31:16], storeData_i[7:0], ramData_i[7:0]};
        end else begin
            storeByteBuffer <= {ramData_i[31:8], storeData_i[7:0]};
        end
    end
end
reg[7:0] ramByte;
wire[31:0] signData = {{24{ramByte[7]}}, ramByte[7:0]}; 
wire[31:0] zeroData = {24'h0, ramByte[7:0]}; 
always @(*) begin
    if (ramAddr_i[1:0] == 2'b00) begin
        ramByte = ramData_i[7:0];
    end else if (ramAddr_i[1:0] == 2'b01) begin
        ramByte = ramData_i[15:8];
    end else if (ramAddr_i[1:0] == 2'b10) begin
        ramByte = ramData_i[23:16];
    end else begin
        ramByte = ramData_i[31:24];
    end
end
always @(*) begin
    if (memState == `S_IDLE) begin 
        pauseRequest = `Disable;
        ramOp_o = `MEM_NOP_OP;
        storeData_o = `ZeroWord;
        ramAddr_o = `ZeroWord;
        ramData_o = `ZeroWord;
        ins_o = `ZeroWord;
        exceptionMEM_o = `EXC_NONE;
        exceptionIF_o = `EXC_NONE;
    end else if (memState == `S_INST) begin 
        if (ramOp_i == `MEM_NOP_OP) begin
            pauseRequest = `Disable;
        end else begin
            pauseRequest = `Enable;
        end
        ramOp_o = `MEM_LW_OP;
        storeData_o = `ZeroWord;
        ramAddr_o = insAddr_i;
        ramData_o = `ZeroWord;
        ins_o = ramData_i;
        exceptionMEM_o = `EXC_NONE;
        exceptionIF_o = exception_i;
    end else if (memState == `S_SB_STORE) begin 
        pauseRequest = `Disable;
        ramOp_o = `MEM_SW_OP;
        storeData_o = storeByteBuffer;
        ramAddr_o = ramAddrAligned;
        ramData_o = `ZeroWord;
        ins_o = dataBuffer;
        exceptionMEM_o = exception_i;
        exceptionIF_o = exceptionBuffer;
    end else if (memState == `S_SB_LOAD) begin 
        pauseRequest = `Enable;
        ramOp_o = `MEM_LW_OP;
        storeData_o = `ZeroWord;
        ramAddr_o = ramAddrAligned;
        ramData_o = `ZeroWord;
        ins_o = dataBuffer;
        exceptionMEM_o = exception_i;
        exceptionIF_o = exceptionBuffer;
    end else begin 
        pauseRequest = `Disable;
        ramOp_o = ramOp_i;
        storeData_o = storeData_i;
        ramAddr_o = ramAddr_i;
        ramData_o = ramData_i;
        ins_o = dataBuffer;
        exceptionMEM_o = exception_i;
        exceptionIF_o = exceptionBuffer;
        if (ramOp_i == `MEM_LB_OP) begin 
            ramOp_o = `MEM_LW_OP;
            ramAddr_o = ramAddrAligned;
            ramData_o = signData;
        end else if (ramOp_i == `MEM_LBU_OP) begin 
            ramOp_o = `MEM_LW_OP;
            ramAddr_o = ramAddrAligned;
            ramData_o = zeroData;
        end
    end
end
endmodule