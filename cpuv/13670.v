module flashcontrol(
    input wire clk25,
    input wire rst,
    input wire[2:0] ramOp_i,
    input wire[22:0] ramAddr_i,
    input wire[15:0] storeData_i,
    input wire[15:0] ramData_i,
    output wire flashEnable_o,
    output wire readEnable_o,
    output wire writeEnable_o,
    output wire busEnable_o,
    output wire[22:0] ramAddr_o,
    output reg[15:0] writeData_o,
    output wire pauseRequest_o,
    output wire[31:0] ramData_o
    );
    reg[2:0] state = 0;
    reg[2:0] counter = 0;
    reg[15:0] dataBuffer = 0;
    wire stateIdle = (state == `S_FLASH_IDLE);
    wire runningErase = (state == `S_FLASH_ERASE);
    wire runningRead = (state == `S_FLASH_READ);
    wire runningWrite = (state == `S_FLASH_WRITE);
    wire runningStatus = (state == `S_FLASH_STATUS);
    wire[3:0] runningVec = {runningErase, runningRead, runningWrite, runningStatus};
    wire running = runningErase | runningRead | runningWrite | runningStatus;
    wire stateChange = (stateIdle || counter == 5);
    wire flashReady = dataBuffer[7];
    wire setupEnable = (counter == 0 || counter == 1);
    wire setupBusEnable = (counter == 0 || counter == 1 || counter == 2);
    wire dataEnable = (counter == 3 || counter == 4);
    wire dataBusEnable = (counter == 3 || counter == 4 || counter == 5);
    assign pauseRequest_o = (running && !((runningRead || runningStatus && flashReady) && counter == 5));
    assign flashEnable_o = ~rst;
    assign readEnable_o = ((runningRead || runningStatus) && dataEnable);
    assign writeEnable_o = (running && setupEnable || (runningWrite || runningErase) && dataEnable);
    assign busEnable_o = (running && setupBusEnable || (runningWrite || runningErase) && dataBusEnable);
    assign ramData_o = (runningRead) ? {16'h0, dataBuffer} : `ZeroWord;
    assign ramAddr_o = (state == `S_FLASH_IDLE) ? 23'h0 : ramAddr_i;
    always @(*) begin
        if (!busEnable_o) begin
            writeData_o = `ZeroHalfWord;
        end else if (setupBusEnable) begin
            case (runningVec)
                4'b1000: writeData_o = 16'h0020;
                4'b0100: writeData_o = 16'h00ff;
                4'b0010: writeData_o = 16'h0040;
                4'b0001: writeData_o = 16'h0070;
                default: writeData_o = `ZeroHalfWord;
            endcase
        end else if (dataBusEnable) begin
            case (runningVec)
                4'b1000: writeData_o = 16'h00d0;
                4'b0010: writeData_o = storeData_i;
                default: writeData_o = `ZeroHalfWord;
            endcase
        end else begin
            writeData_o = `ZeroHalfWord;
        end
    end
    always @(negedge clk25) begin
        if (rst == `Enable) begin
            dataBuffer <= `ZeroHalfWord;
        end else if ((runningRead || runningStatus) && counter == 4) begin
            dataBuffer <= ramData_i;
        end
    end
    always @(negedge clk25) begin
        if (rst == `Enable) begin
            state <= `S_FLASH_IDLE;
        end else if (stateChange) begin
            case (state)
                `S_FLASH_IDLE, `S_FLASH_READ: begin
                    case (ramOp_i)
                        `MEM_LW_OP: state <= `S_FLASH_READ;
                        `MEM_SW_OP: state <= `S_FLASH_WRITE;
                        `MEM_ERASE_OP: state <= `S_FLASH_ERASE;
                        default: state <= `S_FLASH_IDLE;
                    endcase
                end
                `S_FLASH_ERASE, `S_FLASH_WRITE: begin
                    state <= `S_FLASH_STATUS;
                end
                `S_FLASH_STATUS: begin
                    if (flashReady) begin
                        case (ramOp_i)
                            `MEM_LW_OP: state <= `S_FLASH_READ;
                            `MEM_SW_OP: state <= `S_FLASH_WRITE;
                            `MEM_ERASE_OP: state <= `S_FLASH_ERASE;
                            default: state <= `S_FLASH_IDLE;
                        endcase
                    end else begin
                        state <= `S_FLASH_STATUS;
                    end
                end
                default: begin
                    state <= `S_FLASH_IDLE;
                end
            endcase
        end
    end
    always @(negedge clk25) begin
        if (rst == `Enable) begin
            counter <= 0;
        end else if (stateIdle) begin
            counter <= 0;
        end else begin
            counter <= (counter == 5) ? (runningStatus && !flashReady ? 3'h3 : 3'h0) : counter + 3'h1;
        end
    end
endmodule