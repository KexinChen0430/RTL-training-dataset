module uart_echo (
   TX, 
   CLK, 
   RESET, 
   RX 
   ) ;
   input CLK; 
   input RESET; 
   input RX; 
   output TX; 
   reg [7:0] tx_byte; 
   reg       transmit; 
   reg       rx_fifo_pop; 
   wire [7:0] rx_byte; 
   wire       irq; 
   wire       busy; 
   wire       tx_fifo_full; 
   wire       rx_fifo_empty; 
   wire       is_transmitting; 
   uart_fifo uart_fifo(
                       .rx_byte         (rx_byte[7:0]), 
                       .tx              (TX), 
                       .irq             (irq), 
                       .busy            (busy), 
                       .tx_fifo_full    (tx_fifo_full), 
                       .rx_fifo_empty   (rx_fifo_empty), 
                       .tx_byte         (tx_byte[7:0]), 
                       .clk             (CLK), 
                       .rst             (RESET), 
                       .rx              (RX), 
                       .transmit        (transmit), 
                       .rx_fifo_pop     (rx_fifo_pop)); 
   always @(posedge CLK)
     if (RESET) begin
        tx_byte <= 8'h00; 
        transmit <= 1'b0; 
        rx_fifo_pop <= 1'b0; 
     end else begin
        if (!rx_fifo_empty & !tx_fifo_full & !transmit ) begin
           tx_byte <= rx_byte; 
           transmit <= 1'b1; 
           rx_fifo_pop <= 1'b1; 
        end else begin
           tx_byte <= 8'h00; 
           transmit <= 1'b0; 
           rx_fifo_pop <= 1'b0; 
        end
     end 
endmodule