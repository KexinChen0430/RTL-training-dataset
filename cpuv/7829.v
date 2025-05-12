module mkmif_spi( 
 input wire           clk, 
 input wire           reset_n, 
 output wire          spi_sclk, 
 output wire          spi_cs_n, 
 input wire           spi_do, 
 output wire          spi_di, 
 input wire           set, 
 input wire           start, 
 input wire [2 : 0]   length, 
 input wire [15 : 0]  divisor, 
 output wire          ready, 
 input wire [55 : 0]  wr_data, 
 output wire [31 : 0] rd_data 
);
endmodule