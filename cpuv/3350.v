module oled_spi(
  input wire clock, 
  input wire reset, 
  input wire shutdown, 
  output wire cs, 
  output reg sdin, 
  output wire sclk, 
  output reg dc, 
  output reg res, 
  output reg vbatc, 
  output reg vddc 
);