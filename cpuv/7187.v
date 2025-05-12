module uart_decoder #( 
    parameter BAUD_RATE = 115200 
    )(
    input             clk, 
    input             uart_rx, 
    output  reg [7:0] rx_data 
    );
    localparam UART_PERIOD = 1000000000/BAUD_RATE;   
    always @(posedge clk) begin 
        task_uart_rx; 
    end
    task task_uart_rx; 
        reg [7:0] rx_buffer;    
        integer rx_cnt;         
        begin
            #(1);                   
            @(negedge uart_rx);     
            rx_buffer = 0;          
            #(3*UART_PERIOD/2);     
            for (rx_cnt = 0; rx_cnt < 8; rx_cnt = rx_cnt + 1) begin 
                rx_buffer = {uart_rx, rx_buffer[7:1]};      
                #(UART_PERIOD);                     
            end
            rx_data = rx_buffer;       
        end
    endtask 
endmodule 