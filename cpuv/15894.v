module qlal3_spi_cell (
  input         A2F_ACK,         
  output [ 7:0] A2F_ADDR,        
  output [ 7:0] A2F_Control,     
  input  [ 7:0] A2F_GP_IN,       
  output [ 7:0] A2F_GP_OUT,      
  input  [ 7:0] A2F_RD_DATA,     
  output        A2F_REQ,         
  output        A2F_RWn,         
  input  [ 6:0] A2F_Status,      
  output [ 7:0] A2F_WR_DATA,     
  input         af_spi_cpha,     
  input         af_spi_cpol,     
  input         af_spi_lsbf,     
  input         SPI_CLK,         
  input         SPI_CLKS,        
  output        SPI_MISO,        
  output        SPI_MISOe,       
  input         SPI_MOSI,        
  input         SPI_SSn          
);
endmodule