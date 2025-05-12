module uart_ctrl (
    input  wire                 clk,      
    input  wire                 reset,    
    input  wire                 cs_,      
    input  wire                 as_,      
    input  wire                 rw,       
    input  wire [`UartAddrBus]  addr,     
    input  wire [`WordDataBus]  wr_data,  
    output reg  [`WordDataBus]  rd_data,  
    output reg                  rdy_,     
    output reg                  irq_rx,   
    output reg                  irq_tx,   
    input  wire                 rx_busy,  
    input  wire                 rx_end,   
    input  wire [`ByteDataBus]  rx_data,  
    input  wire                 tx_busy,  
    input  wire                 tx_end,   
    output reg                  tx_start, 
    output reg  [`ByteDataBus]  tx_data   
);
    reg [`ByteDataBus]          rx_buf;   
    always @(posedge clk or `RESET_EDGE reset) begin
        if (reset == `RESET_ENABLE) begin
            rd_data   <= #1 `WORD_DATA_W'h0;
            rdy_      <= #1 `DISABLE_;
            irq_rx    <= #1 `DISABLE;
            irq_tx    <= #1 `DISABLE;
            rx_buf    <= #1 `BYTE_DATA_W'h0;
            tx_start  <= #1 `DISABLE;
            tx_data   <= #1 `BYTE_DATA_W'h0;
        end else begin
            if ((cs_ == `ENABLE_) && (as_ == `ENABLE_)) begin
                rdy_   <= #1 `ENABLE_;
            end else begin
                rdy_   <= #1 `DISABLE_;
            end
            if ((cs_ == `ENABLE_) && (as_ == `ENABLE_) && (rw == `READ)) begin
                case (addr)
                    `UART_ADDR_STATUS   : begin 
                        rd_data   <= #1 {{`WORD_DATA_W-4{1'b0}},
                                        tx_busy, rx_busy, irq_tx, irq_rx};
                    end
                    `UART_ADDR_DATA     : begin 
                        rd_data   <= #1 {{`BYTE_DATA_W*2{1'b0}}, rx_buf};
                    end
                endcase
            end else begin
                rd_data   <= #1 `WORD_DATA_W'h0;
            end
            if (tx_end == `ENABLE) begin
                irq_tx <= #1 `ENABLE;
            end else if ((cs_ == `ENABLE_) && (as_ == `ENABLE_) &&
                         (rw == `WRITE) && (addr == `UART_ADDR_STATUS)) begin
                irq_tx <= #1 wr_data[`UartCtrlIrqTx];
            end
            if (rx_end == `ENABLE) begin
                irq_rx <= #1 `ENABLE;
            end else if ((cs_ == `ENABLE_) && (as_ == `ENABLE_) &&
                         (rw == `WRITE) && (addr == `UART_ADDR_STATUS)) begin
                irq_rx <= #1 wr_data[`UartCtrlIrqRx];
            end
            if ((cs_ == `ENABLE_) && (as_ == `ENABLE_) &&
                (rw == `WRITE) && (addr == `UART_ADDR_DATA)) begin
                tx_start <= #1 `ENABLE;
                tx_data  <= #1 wr_data[`BYTE_MSB:`LSB];
            end else begin
                tx_start <= #1 `DISABLE;
                tx_data  <= #1 `BYTE_DATA_W'h0;
            end
            if (rx_end == `ENABLE) begin
                rx_buf   <= #1 rx_data;
            end
        end
    end
endmodule