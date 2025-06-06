module sd_cmd_master(
    input sd_clk, 
    input rst, 
    input start_i, 
    input int_status_rst_i, 
    output [1:0] setting_o, 
    output reg start_xfr_o, 
    output reg go_idle_o, 
    output reg [39:0] cmd_o, 
    input [119:0] response_i, 
    input crc_ok_i, 
    input index_ok_i, 
    input finish_i, 
    input busy_i, 
    input [31:0] argument_i, 
    input [`CMD_REG_SIZE-1:0] command_i, 
    input [15:0] timeout_i, 
    output [`INT_CMD_SIZE-1:0] int_status_o, 
    output reg [31:0] response_0_o, 
    output reg [31:0] response_1_o, 
    output reg [31:0] response_2_o, 
    output reg [31:0] response_3_o 
);
reg [15:0] timeout_reg; 
reg crc_check; 
reg index_check; 
reg busy_check; 
reg expect_response; 
reg long_response; 
reg [`INT_CMD_SIZE-1:0] int_status_reg; 
reg [15:0] watchdog; 
parameter SIZE = 2; 
reg [SIZE-1:0] state; 
reg [SIZE-1:0] next_state; 
parameter IDLE       = 2'b00; 
parameter EXECUTE    = 2'b01; 
parameter BUSY_CHECK = 2'b10; 
assign setting_o[1:0] = {long_response, expect_response};
assign int_status_o = state == IDLE ? int_status_reg : 5'h0;
always @(state or start_i or finish_i or go_idle_o or busy_check or busy_i)
begin: FSM_COMBO
    case(state)
        IDLE: begin
            if (start_i)
                next_state <= EXECUTE; 
            else
                next_state <= IDLE; 
        end
        EXECUTE: begin
            if ((finish_i && !busy_check) || go_idle_o)
                next_state <= IDLE; 
            else if (finish_i && busy_check)
                next_state <= BUSY_CHECK; 
            else
                next_state <= EXECUTE; 
        end
        BUSY_CHECK: begin
            if (!busy_i)
                next_state <= IDLE; 
            else
                next_state <= BUSY_CHECK; 
        end
        default: next_state <= IDLE; 
    endcase
end
always @(posedge sd_clk or posedge rst)
begin: FSM_SEQ
    if (rst) begin
        state <= IDLE; 
    end
    else begin
        state <= next_state; 
    end
end
always @(posedge sd_clk or posedge rst)
begin
    if (rst) begin
        crc_check <= 0;
        response_0_o <= 0;
        response_1_o <= 0;
        response_2_o <= 0;
        response_3_o <= 0;
        int_status_reg <= 0;
        expect_response <= 0;
        long_response <= 0;
        cmd_o <= 0;
        start_xfr_o <= 0;
        index_check <= 0;
        busy_check <= 0;
        watchdog <= 0;
        timeout_reg <= 0;
        go_idle_o <= 0;
    end
    else begin
        case(state)
            IDLE: begin
                go_idle_o <= 0;
                index_check <= command_i[`CMD_IDX_CHECK];
                crc_check <= command_i[`CMD_CRC_CHECK];
                busy_check <= command_i[`CMD_BUSY_CHECK];
                if (command_i[`CMD_RESPONSE_CHECK]  == 2'b10 || command_i[`CMD_RESPONSE_CHECK] == 2'b11) begin
                    expect_response <=  1;
                    long_response <= 1;
                end
                else if (command_i[`CMD_RESPONSE_CHECK] == 2'b01) begin
                    expect_response <= 1;
                    long_response <= 0;
                end
                else begin
                    expect_response <= 0;
                    long_response <= 0;
                end
                cmd_o[39:38] <= 2'b01; 
                cmd_o[37:32] <= command_i[`CMD_INDEX]; 
                cmd_o[31:0] <= argument_i; 
                timeout_reg <= timeout_i;
                watchdog <= 0;
                if (start_i) begin
                    start_xfr_o <= 1; 
                    int_status_reg <= 0; 
                end
            end
            EXECUTE: begin
                start_xfr_o <= 0; 
                watchdog <= watchdog + 16'd1; 
                if (watchdog > timeout_reg) begin
                    int_status_reg[`INT_CMD_CTE] <= 1; 
                    int_status_reg[`INT_CMD_EI] <= 1; 
                    go_idle_o <= 1; 
                end
                else begin
                    if (finish_i) begin 
                        if (crc_check & !crc_ok_i) begin
                            int_status_reg[`INT_CMD_CCRCE] <= 1; 
                            int_status_reg[`INT_CMD_EI] <= 1; 
                        end
                        if (index_check & !index_ok_i) begin
                            int_status_reg[`INT_CMD_CIE] <= 1; 
                            int_status_reg[`INT_CMD_EI] <= 1; 
                        end
                        int_status_reg[`INT_CMD_CC] <= 1; 
                        if (expect_response != 0) begin
                            response_0_o <= response_i[119:88];
                            response_1_o <= response_i[87:56];
                            response_2_o <= response_i[55:24];
                            response_3_o <= {response_i[23:0], 8'h00};
                        end
                    end
                end
            end
            BUSY_CHECK: begin
                start_xfr_o <= 0; 
                go_idle_o <= 0; 
            end
        endcase
        if (int_status_rst_i)
            int_status_reg <= 0;
    end
end
endmodule 