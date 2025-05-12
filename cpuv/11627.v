module sramcontrol(
    input wire clk50,
    input wire rst,
    input wire[2:0] ramOp_i,
    input wire[31:0] storeData_i,
    input wire[21:0] ramAddr_i,
    input wire[31:0] ramData_i,
    output wire[21:0] ramAddr_o,
    output wire sramEnable_o,
    output wire writeEnable_o,
    output wire busEnable_o,
    output wire[31:0] writeData_o,
    output wire readEnable_o,
    output wire[31:0] ramData_o
    );
    reg[2:0] state;
    assign sramEnable_o = ~rst;
    assign readEnable_o = (state == `S_READ1 || state == `S_READ2);
    assign writeEnable_o = (state == `S_WRITE1);
    assign busEnable_o = (state == `S_WRITE1 || state == `S_WRITE2);
    assign writeData_o = storeData_i;
    assign ramData_o = readEnable_o ? ramData_i : `ZeroWord;
    assign ramAddr_o = (state == `S_IDLE) ? 22'h0 : ramAddr_i;
    always @(posedge clk50) begin
        if (rst == `Enable) begin
            state <= `S_IDLE;
        end else if (state == `S_WRITE1) begin
            state <= `S_WRITE2;
        end else if (state == `S_READ1) begin
            state <= `S_READ2;
        end else if (ramOp_i == `MEM_LW_OP) begin
            state <= `S_READ1;
        end else if (ramOp_i == `MEM_SW_OP) begin
            state <= `S_WRITE1;
        end else begin
            state <= `S_IDLE;
        end
    end
endmodule