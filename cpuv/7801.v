module BaudRateGenerator(
    input [28:0] baudrate, 
    input rst,             
    input clk,             
    output baudclk         
);
  parameter SYS_CLK_RATE = 50000000; 
  reg [28:0] d;
  wire [28:0] dInc = d[28] ? (baudrate) : (baudrate - SYS_CLK_RATE);
  always @(posedge clk or posedge rst)
    d <= (rst) ? ((baudrate - SYS_CLK_RATE) >>> 1 ) : (d + dInc);
  assign baudclk = ~d[28] & ~rst; 
endmodule