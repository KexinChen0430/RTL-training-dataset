module spi_master( 
clk,rst_n, 
spi_miso,spi_mosi,spi_clk, 
spi_tx_en,spi_rx_en,spi_over,mode_select,receive_status, 
cs 
);
input clk; 
input rst_n; 
input spi_miso; 
output spi_mosi; 
output spi_clk; 
output cs; 
input spi_tx_en; 
output spi_over; 
output receive_status; 
input spi_rx_en; 
input mode_select; 
reg[7:0] data_count; 
reg[7:0] recv_detect; 
reg[7:0] spi_tx_db; 
reg[4:0] cnt8; 
reg spi_clkr; 
reg spi_mosir; 
reg spi_mosir1; 
reg receive_status; 
reg[7:0] spi_rx_dbr; 
reg[7:0] spi_rx_dbr1; 
reg frame_delay; 
reg start_delay; 
reg cs; 
reg[7:0] frame_delay_cnt; 
reg[7:0] start_delay_cnt; 
wire[7:0] spi_rx_db; 
wire[4:0] mode_reg; 
wire[4:0] start_reg; 
assign mode_reg = mode_select ? 5'd18 : 5'd17; 
assign start_reg = mode_select ? 5'd1 : 5'd0; 
always @(posedge clk or negedge rst_n) begin 
end
always @(posedge clk or negedge rst_n)begin 
end
always @(posedge clk or negedge rst_n)begin 
end
always @(posedge clk or negedge rst_n) begin 
end
assign spi_clk = spi_clkr; 
always @(posedge clk or negedge rst_n) begin 
end
always @(posedge clk or negedge rst_n) begin 
end
assign spi_mosi = mode_select ? spi_mosir1 : spi_mosir; 
always @(posedge clk or negedge rst_n) begin 
end
always @(posedge clk or negedge rst_n) begin 
end
assign spi_rx_db = mode_select ? spi_rx_dbr1 : spi_rx_dbr; 
assign spi_over = (data_count == 8'd64) ? 1'b1 :1'b0; 
always @(posedge clk or negedge rst_n) begin 
end
endmodule 