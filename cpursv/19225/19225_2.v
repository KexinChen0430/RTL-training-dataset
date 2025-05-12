
module lcd_display(input  [1:0] address,
                   input  begintransfer,
                   input  read,
                   input  write,
                   input  [7:0] writedata,
                   output LCD_E,
                   output LCD_RS,
                   output LCD_RW,
                   inout  [7:0] LCD_data,
                   output [7:0] readdata);

  wire LCD_E;
  wire LCD_RS;
  wire LCD_RW;
  wire [7:0] LCD_data;
  wire [7:0] readdata;

  assign LCD_RW = address[0];
  assign LCD_RS = address[1];
  assign LCD_E = read | write;
  assign LCD_data = address[0] ? 8'bz : writedata;
  assign readdata = LCD_data;
endmodule

