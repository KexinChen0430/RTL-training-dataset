
module SPX9(DO,DI,BLKSEL,AD,WRE,CLK,CE,OCE,RESET);

  parameter  READ_MODE = 1'b0;
  parameter  WRITE_MODE = 2'b00;
  parameter  BIT_WIDTH = 36;
  parameter  BLK_SEL = 3'b000;
  parameter  RESET_MODE = SYNC;
  parameter  INIT_RAM_00 = 288'h0;
  parameter  INIT_RAM_01 = 288'h0;
  parameter  INIT_RAM_3F = 288'h0;
  output [35:0] DO;
  input  [35:0] DI;
  input  [2:0] BLKSEL;
  input  [13:0] AD;
  input  WRE;
  input  CLK;
  input  CE;
  input  OCE;
  input  RESET;


endmodule

