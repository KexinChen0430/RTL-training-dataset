
module pixel(input  clk,
             input  pixclk,
             input  [7:0] attcode,
             input  pixel,
             input  blank,
             input  hsync_in,
             input  vsync_in,
             input  blink,
             output reg hsync,
             output reg vsync,
             output reg [2:0] r,
             output reg [2:0] g,
             output reg [2:0] b);

  wire blink_bit;
  wire bg_red;
  wire bg_green;
  wire bg_blue;
  wire inten_bit;
  wire fg_red;
  wire fg_green;
  wire fg_blue;
  wire foreground;
  wire intensify;
  wire red;
  wire green;
  wire blue;

  assign blink_bit = attcode[7];
  assign bg_red = attcode[6];
  assign bg_green = attcode[5];
  assign bg_blue = attcode[4];
  assign inten_bit = attcode[3];
  assign fg_red = attcode[2];
  assign fg_green = attcode[1];
  assign fg_blue = attcode[0];
  assign foreground = pixel & ~(blink_bit & blink);
  assign intensify = foreground & inten_bit;
  assign red = foreground ? fg_red : bg_red;
  assign green = foreground ? fg_green : bg_green;
  assign blue = foreground ? fg_blue : bg_blue;
  
  always @(posedge clk)
      begin
        if (pixclk == 1) 
          begin
            hsync <= hsync_in;
            vsync <= vsync_in;
            r[2] <= red & blank;
            r[1] <= intensify & blank;
            r[0] <= (intensify & blank) & red;
            g[2] <= blank & green;
            g[1] <= intensify & blank;
            g[0] <= intensify & (blank & green);
            b[2] <= blank & blue;
            b[1] <= intensify & blank;
            b[0] <= intensify & (blank & blue);
          end
          
      end
endmodule

