module SPI_Master ( Reset_n, Clk, CPOL_i, CPHA_i, LSBFE_i, SPPR_i,
        SPR_i, SCK_o, MOSI_o, MISO_i, Transmission_o, Write_i, ReadNext_i,
        Data_i, Data_o, FIFOFull_o, FIFOEmpty_o, ScanEnable_i, ScanClk_i,
        ScanDataIn_i, ScanDataOut_o );
  parameter DataWidth = 8;
  parameter SPPRWidth = 3;
  parameter SPRWidth = 3;
  parameter FIFOReadWidth = 4;
  parameter FIFOWriteWidth = 4;
  input [(SPPRWidth-1):0] SPPR_i;
  input [(SPRWidth-1):0] SPR_i;
  input [(DataWidth-1):0] Data_i;
  output [7:0] Data_o;
  input Reset_n, Clk, CPOL_i, CPHA_i, LSBFE_i, MISO_i, Write_i, ReadNext_i,
         ScanEnable_i, ScanClk_i, ScanDataIn_i;
  output SCK_o, MOSI_o, Transmission_o, FIFOFull_o, FIFOEmpty_o, ScanDataOut_o;
  parameter X = 3;
endmodule