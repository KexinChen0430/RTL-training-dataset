module sd_data_master (
    input sd_clk, 
    input rst, 
    input start_tx_i, 
    input start_rx_i, 
    input [`DATA_TIMEOUT_W-1:0] timeout_i, 
    output reg d_write_o, 
    output reg d_read_o, 
    output reg start_tx_fifo_o, 
    output reg start_rx_fifo_o, 
    input tx_fifo_empty_i, 
    input tx_fifo_full_i, 
    input rx_fifo_full_i, 
    input xfr_complete_i, 
    input crc_ok_i, 
    output reg [`INT_DATA_SIZE-1:0] int_status_o, 
    input int_status_rst_i 
);
reg [`DATA_TIMEOUT_W-1:0] timeout_reg; 
reg [`DATA_TIMEOUT_W-1:0] watchdog; 
reg tx_cycle; 
parameter SIZE = 3; 
reg [SIZE-1:0] state; 
reg [SIZE-1:0] next_state; 
parameter IDLE          = 3'b000; 
parameter START_TX_FIFO = 3'b001; 
parameter START_RX_FIFO = 3'b010; 
parameter DATA_TRANSFER = 3'b100; 
reg trans_done; 
always @(state or start_tx_i or start_rx_i or tx_fifo_full_i or xfr_complete_i or trans_done)
begin: FSM_COMBO
    case(state)
        IDLE: begin 
            if (start_tx_i == 1) begin 
                next_state <= START_TX_FIFO; 
            end
            else if (start_rx_i == 1) begin 
                next_state <= START_RX_FIFO; 
            end
            else begin 
                next_state <= IDLE; 
            end
        end
        START_TX_FIFO: begin 
            if (tx_fifo_full_i == 1 && xfr_complete_i == 0) 
                next_state <= DATA_TRANSFER; 
            else 
                next_state <= START_TX_FIFO; 
        end
        START_RX_FIFO: begin 
            if (xfr_complete_i == 0) 
                next_state <= DATA_TRANSFER; 
            else 
                next_state <= START_RX_FIFO; 
        end
        DATA_TRANSFER: begin 
            if (trans_done) 
                next_state <= IDLE; 
            else 
                next_state <= DATA_TRANSFER; 
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
        start_tx_fifo_o <= 0;
        start_rx_fifo_o <= 0;
        d_write_o <= 0;
        d_read_o <= 0;
        trans_done <= 0;
        tx_cycle <= 0;
        int_status_o <= 0;
        timeout_reg <= 0;
        watchdog <= 0;
    end
    else begin 
        case(state) 
            IDLE: begin 
                start_tx_fifo_o <= 0;
                start_rx_fifo_o <= 0;
                d_write_o <= 0;
                d_read_o <= 0;
                trans_done <= 0;
                tx_cycle <= 0;
                timeout_reg <= timeout_i;
                watchdog <= 0;
            end
            START_RX_FIFO: begin 
                start_rx_fifo_o <= 1;
                start_tx_fifo_o <= 0;
                tx_cycle <= 0;
                d_read_o <= 1;
            end
            START_TX_FIFO:  begin 
                start_rx_fifo_o <= 0;
                start_tx_fifo_o <= 1;
                tx_cycle <= 1;
                if (tx_fifo_full_i == 1) 
                    d_write_o <= 1; 
            end
            DATA_TRANSFER: begin 
                d_read_o <= 0;
                d_write_o <= 0;
                watchdog <= watchdog + `DATA_TIMEOUT_W'd1;
                if (tx_cycle) begin 
                    if (tx_fifo_empty_i) begin 
                        if (!trans_done) begin 
                            int_status_o[`INT_DATA_CFE] <= 1;
                            int_status_o[`INT_DATA_EI] <= 1;
                        end
                        trans_done <= 1; 
                        d_write_o <= 1;
                        d_read_o <= 1;
                    end
                end
                else begin 
                    if (rx_fifo_full_i) begin 
                        if (!trans_done) begin 
                            int_status_o[`INT_DATA_CFE] <= 1;
                            int_status_o[`INT_DATA_EI] <= 1;
                        end
                        trans_done <= 1; 
                        d_write_o <= 1;
                        d_read_o <= 1;
                    end
                end
                if (timeout_reg && watchdog >= timeout_reg) begin 
                    int_status_o[`INT_DATA_CTE] <= 1;
                    int_status_o[`INT_DATA_EI] <= 1;
                    trans_done <= 1; 
                    d_write_o <= 1;
                    d_read_o <= 1;
                end
                else if (xfr_complete_i) begin 
                    d_write_o <= 0;
                    d_read_o <= 0;
                    trans_done <= 1; 
                    if (!crc_ok_i)  begin 
                        if (!trans_done) begin 
                            int_status_o[`INT_DATA_CCRCE] <= 1;
                            int_status_o[`INT_DATA_EI] <= 1;
                        end
                    end
                    else if (crc_ok_i) begin 
                        if (!trans_done) 
                            int_status_o[`INT_DATA_CC] <= 1;
                    end
                end
            end
        endcase
        if (int_status_rst_i) 
            int_status_o<=0; 
    end
end
endmodule