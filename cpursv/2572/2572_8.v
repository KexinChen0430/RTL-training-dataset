
module SPI_testbench();

  parameter integer  m = 16;
  reg  GCLK;
  reg  st;
  reg  LEFT;
  reg  RST;
  wire MISO;
  wire MOSI;
  wire SS;
  wire SCLK;
  wire [m+(-1):0] MASTER_RX;
  reg  [m+(-1):0]  MASTER_TX = 16'hdeaf;
  wire [m+(-1):0] SLAVE_RX;
  reg  [m+(-1):0]  SLAVE_TX = 16'b110101100110110;
  wire clk_Tbit;

  SPI_sender spi_master(.CLK(GCLK),.DATA(MASTER_TX),.T_DIV(1+1),
                        .RST(RST),.ST(st),.SCK(SCLK),.MOSI(MOSI),.SS(SS));
  SPI_SLAVE #(.m(m)) spi_slave(.RST(RST),.SCLK(SCLK),.MISO(MISO),
                               .MOSI(MOSI),.SS(SS),.DIN(SLAVE_TX),.DOUT(SLAVE_RX));
  
  always 
      begin
        GCLK = 1'b0;
        #10 ;
        GCLK = 1'b1;
        #10 ;
      end
  
  initial  
  begin
    GCLK = 1'b0;
    st = 1'b0;
    LEFT = 1'b1;
    RST = 1'b0;
    #100 st = 1'b1;
    #200 st = 1'b0;
    #11000 MASTER_TX = 16'habcd; st = 1'b1;
    #200 st = 1'b0;
    #8000 $finish;
  end
endmodule

