module spi_slave #(
    parameter WORDSIZE    = 8,    
    parameter CPOL        = 0,    
    parameter CPHA        = 0,    
    parameter MSB_FIRST   = 1,    
) (
    input clk,                      
    input mosi,                     
    output miso,                    
    input sck,                      
    input ss,                       
    output rx_irq,                  
    output [WORDSIZE - 1 : 0] rx_data, 
    input [WORDSIZE - 1 : 0] tx_data   
);
    wire mosi_s;                    
    wire sck_rising_s;              
    wire sck_falling_s;             
    wire ss_s;                      
    sync_signal sync_mosi(.clk(clk), .in(mosi), .out(mosi_s));
    sync_signal sync_sck(.clk(clk), .in(sck), .rising(sck_rising_s), .falling(sck_falling_s));
    sync_signal sync_ss(.clk(clk), .in(ss), .out(ss_s));
    wire sck_sample_edge;           
    wire sck_setup_edge;            
    assign sck_sample_edge = (CPOL ^ CPHA) ? sck_falling_s : sck_rising_s;
    assign sck_setup_edge = (CPOL ^ CPHA) ? sck_rising_s : sck_falling_s;
    reg miso_r;                     
    reg rx_irq_r;                   
    reg [WORDSIZE - 1 : 0] rx_data_r; 
    assign miso = miso_r;           
    assign rx_irq = rx_irq_r;       
    assign rx_data = rx_data_r;     
    reg [WORDSIZE - 1 : 0] rx_shiftreg; 
    reg [WORDSIZE - 1 : 0] tx_shiftreg; 
    reg [5:0] bit_count;                
    initial begin
        bit_count <= 0;
        rx_shiftreg <= 0;
        tx_shiftreg <= 0;
        miso_r <= 0;
        rx_irq_r <= 0;
        rx_data_r <= 0;
    end
    always @(posedge clk) begin
        if (ss_s) begin
            bit_count <= 0;
            rx_shiftreg <= 0;
            tx_shiftreg <= 0;
            miso_r <= 0;
            rx_irq_r <= 0;
        end else begin
            if (bit_count == 0) begin
                if (CPHA) begin
                    tx_shiftreg <= tx_data;
                    miso_r <= 0;
                end else begin
                    if (MSB_FIRST) begin
                        tx_shiftreg <= tx_data << 1;
                        miso_r <= tx_data[WORDSIZE - 1];
                    end else begin
                        tx_shiftreg <= tx_data >> 1;
                        miso_r <= tx_data[0];
                    end
                end
            end else if (sck_setup_edge) begin
                if (MSB_FIRST) begin
                    miso_r <= tx_shiftreg[WORDSIZE - 1];
                    tx_shiftreg <= tx_shiftreg << 1;
                end else begin
                    miso_r <= tx_shiftreg[0];
                    tx_shiftreg <= tx_shiftreg >> 1;
                end
            end
            if (sck_sample_edge && (bit_count < WORDSIZE)) begin
                if (MSB_FIRST) begin
                    rx_shiftreg <= rx_shiftreg << 1;
                    rx_shiftreg[0] <= mosi_s;
                end else begin
                    rx_shiftreg <= rx_shiftreg >> 1;
                    rx_shiftreg[WORDSIZE - 1] <= mosi_s;
                end
                bit_count <= bit_count + 1;
            end
            if (bit_count >= WORDSIZE) begin
                bit_count <= 0;
                rx_data_r <= rx_shiftreg;
                rx_irq_r <= 1;
            end else begin
                rx_irq_r <= 0;
            end
        end
    end
endmodule